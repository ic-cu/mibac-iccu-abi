package xml;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.FilenameFilter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Iterator;
import java.util.List;
import java.util.ListIterator;
import java.util.Set;
import java.util.TreeSet;

import org.jdom.Attribute;
import org.jdom.Document;
import org.jdom.Element;
import org.jdom.JDOMException;
import org.jdom.input.SAXBuilder;
import org.jdom.xpath.XPath;

/** Description of the Class */

public class VarieQuery
{
	public Connection conn;

	private void err(String str)
	{
		System.err.println(str);
	}

	private void out(String str)
	{
		System.out.println(str);
	}

	public VarieQuery(String driver, String url, String user, String pass)
	{
		try
		{
			Class.forName(driver);
		}
		catch(Exception e)
		{
			err("ERROR: failed to load JDBC driver.");
		}
		try
		{
			conn = DriverManager.getConnection(url, user, pass);
			if(conn == null)
			{
				err("Connessione nulla!");
			}
		}
		catch(SQLException e)
		{
			err("ERROR: failed to connect!");
		}
	}

	public void free()
	{
		try
		{
			conn.close();
		}
		catch(SQLException e)
		{
			this.err("ERROR: Fetch statement failed: " + e.getMessage());
			this.err(e.toString());
		}
	}

	// cerca un valore in tabella.campo

	public void verificaValore(String tabella, String campo, String valore)
	{
		try
		{
			Statement stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);

			// questo sembra l'unico modo di mandare al DB la sequenza "\'"...
			String valore2 = valore.replaceAll("\'", "\\\\'");

			String query = "select " + campo + " from " + tabella;
			query += " where " + campo + " = \'" + valore2 + "\'";
			// query += " where " + campo + " like \'" + valore2 + "\'";
			// out(campo);
			// out(query);
			ResultSet rs = stmt.executeQuery(query);
			rs.last();
			if(rs.getRow() < 1)
			{
				out("  Valore mancante: " + valore);
			}
			if(rs.getRow() > 1)
			{
				out("  Valore duplicato: " + valore);
			}
			rs.close();
			stmt.close();
		}
		catch(SQLException e)
		{
			System.err.println("ERROR: Fetch statement failed: " + e.getMessage());
			System.err.println(e);
		}
	}

	public Document load(File in)
	{
		Document doc = new Document();
		try
		{
			SAXBuilder builder = new SAXBuilder(false);
			doc = builder.build(in);
		}
		catch(JDOMException e)
		{
			e.printStackTrace();
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		return doc;
	}

	/*
	 * Finito il controllo delle voci d'autorità, proviamo a estrarre la lista di
	 * tutte le biblioteche "non censite". Si parte dal documento XML caricato.
	 */

	public String isilNonCensite(Document doc)
	{
		String isilPath = "//biblioteca/anagrafica/codici/isil";
		XPath xp;
		String query = "select";
		query += " concat('IT-', isil_provincia, lpad(isil_numero, 4, 0 ))";
		query += " as isil,";
		query += " sct.descrizione as stato";
		query += " from biblioteca b, stato_catalogazione sc, stato_catalogazione_tipo sct";
		query += " where concat('IT-', isil_provincia, lpad(isil_numero, 4, 0 )) = ?";
		query += " and id_stato_biblioteca_workflow != 4";
		query += " and sc.id_biblioteca = b.id_biblioteca";
		query += " and sc.id_stato_catalogazione = sct.id_stato_catalogazione_tipo";
		String ok = null;
		int count = 0;
		try
		{
			PreparedStatement isilStmt;
			isilStmt = conn.prepareStatement(query, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);

			xp = XPath.newInstance(isilPath);
			System.out.println("Trovate " + doc.getRootElement().getChildren("biblioteca").size() + " biblioteche nei documenti XML");
			Iterator<Element> i = xp.selectNodes(doc).iterator();
			System.out.println("==========\nElenco biblioteche con stato di catalogazione:");
			while(i.hasNext())
			{
				Element node = i.next();
				String isil = node.getTextNormalize();
				if(isil.length() > 0)
				{
					count++;
					isilStmt.setString(1, isil);
					ResultSet rs = isilStmt.executeQuery();
					if(rs.next())
					{
						System.out.println(isil + " --> " + rs.getString("stato"));
					}
					else
					{
						ok += isil + "\n";
					}
				}
				else
				{
					System.out.print("IT-?????? --> ");
					System.out.println(node.getParentElement().getParentElement().getChild("nomi").getChildText("attuale"));
				}
			}
			System.out.println("==========\nTotale biblioteche con ISIL: " + count);
			// System.out.println("Biblioteche senza stato di catalogazione:\n" + ok);
		}
		catch(JDOMException e)
		{
			e.printStackTrace();
		}
		catch(SQLException e)
		{
			e.printStackTrace();
		}
		return ok;
	}

	/*
	 * Un controllo su eventuali biblioteche di fonte AICE in esercizio, che
	 * quindi non andebbero importate
	 */

	public String fonteAICE(Document doc)
	{
		String isilPath = "//biblioteca/anagrafica/codici/isil";
		XPath xp;
		String queryAICE = "select";
		queryAICE += " concat('IT-', isil_provincia, lpad(isil_numero, 4, 0 ))";
		queryAICE += " as isil,";
		queryAICE += " fonte_descrizione";
		queryAICE += " from biblioteca b";
		queryAICE += " where concat('IT-', isil_provincia, lpad(isil_numero, 4, 0 )) = ?";
		queryAICE += " and id_stato_biblioteca_workflow != 4";
		queryAICE += " and fonte_descrizione like '%AICE%'";
		String ok = null;
		int count = 0;
		try
		{
			PreparedStatement aiceStmt;
			aiceStmt = conn.prepareStatement(queryAICE, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);

			xp = XPath.newInstance(isilPath);
// System.out.println("Trovate " +
// doc.getRootElement().getChildren("biblioteca").size() +
// " biblioteche nei documenti XML");
			Iterator<Element> i = xp.selectNodes(doc).iterator();
			System.out.println("==========\nElenco biblioteche con fonte AICE:");
			while(i.hasNext())
			{
				Element node = i.next();
				String isil = node.getTextNormalize();
				if(isil.length() > 0)
				{
					aiceStmt.setString(1, isil);
// System.err.println(isil);
// System.err.println(aiceStmt.toString());
					ResultSet rs = aiceStmt.executeQuery();

					if(rs.next())
					{
						count++;
						System.out.println(isil + " --> " + "è di fonte AICE");
					}
					else
					{
						ok += isil + "\n";
					}
				}
				else
				{
					System.out.print("IT-?????? --> ");
					System.out.println(node.getParentElement().getParentElement().getChild("nomi").getChildText("attuale"));
				}
			}
			System.out.println("==========\nTotale biblioteche con fonte AICE: " + count);
			// System.out.println("Biblioteche senza stato di catalogazione:\n" + ok);
		}
		catch(JDOMException e)
		{
			e.printStackTrace();
		}
		catch(SQLException e)
		{
			e.printStackTrace();
		}
		return ok;
	}

	public static void main(String[] args)
	{
		String driver = args[0];
		String url = args[1];
		String user = args[2];
		String pass = args[3];
		String xml = args[4];
		String riga;
		String parti[];
		String xpath;
		String tabella = null;
		String campo = null;
		VarieQuery vq = new VarieQuery(driver, url, user, pass);
		File[] dir = new File(xml).listFiles(new FilenameFilter()
		{
			public boolean accept(File directory, String fileName)
			{
				return fileName.endsWith(".xml");
			}
		});
		Set ts = null;
		Document doc = new Document(new Element("biblioteche")), doc2;
		System.out.println("root element: " + doc.getRootElement().getName());
		int biblioteche = 0;
		for(int ii = 0; ii < dir.length; ii++)
		{
			if(dir[ii].isFile())
			{
				doc2 = vq.load(dir[ii]);
				Iterator ibib = doc2.getRootElement().getChildren("biblioteca").iterator();
				while(ibib.hasNext())
				{
					Element bib2 = (Element) ibib.next();
					Element bib = new Element("biblioteca");
					bib.addContent(bib2.cloneContent());
					doc.getRootElement().addContent(bib);
					biblioteche++;
				}
			}
		}

		System.out.println("Caricate " + biblioteche + " biblioteche (nel doc sono " + doc.getRootElement().getChildren("biblioteca").size()
				+ ")");

/*
 * Si cercano le biblioteche che risultano non censite in ABI.
 */
		vq.isilNonCensite(doc);
		vq.fonteAICE(doc);

/*
 * Si controllano le voci d'autorità
 */

		System.out.println("==========\nElenco voci d'autorità mancanti");
		try
		{
			BufferedReader conf = new BufferedReader(new FileReader("VarieQuery.conf"));
			while(conf.ready())
			{
				riga = conf.readLine();
				parti = riga.split(" ");
				xpath = parti[0];
				tabella = parti[1];
				campo = parti[2];
				if(!xpath.startsWith("#"))
				{
					vq.out("Percorso: " + xpath);
					try
					{
						XPath xp = XPath.newInstance(xpath);
						List list = xp.selectNodes(doc);
						// vq.out(" " + list.size());

						// itera sulla lista dei nodi estratti dal xpath
						ts = new TreeSet();
						ListIterator li = list.listIterator();
						while(li.hasNext())
						{
							Object e = li.next();
							String c = e.getClass().getName();
							if(c == "org.jdom.Element")
							{
								try
								{
									ts.add(((Element) e).getText());
								}
								catch(java.lang.NullPointerException ex)
								{
									vq.out(e.toString());
								}
							}
							else if(c == "org.jdom.Attribute")
							{
								try
								{
									ts.add(((Attribute) e).getValue());
								}
								catch(java.lang.NullPointerException ex)
								{
									vq.out(e.toString());
								}
							}
							else if(c == "java.lang.String")
							{
								try
								{
									ts.add(e);
									vq.out(e.toString());
								}
								catch(java.lang.NullPointerException ex)
								{
									vq.out(e.toString());
								}
							}

						}

						// itera sul set, quindi stessi dati, ma in ordine e senza
						// ripetizioni
						// (e solo il contenuto)
						Iterator i = ts.iterator();
						while(i.hasNext())
						{
							String valore = (String) i.next();
							// vq.out(tabella + ", " + campo + ", " + valore);
							vq.verificaValore(tabella, campo, valore);
						}
					}
					catch(JDOMException e)
					{
						e.printStackTrace();
					}
				}
				// vq.out(riga);
			}
		}
		catch(java.lang.Exception ex)
		{
			ex.printStackTrace();
		}
	}
}
