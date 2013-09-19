package xml;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.sql.Connection;
import java.sql.DriverManager;
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
			Statement stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
					ResultSet.CONCUR_UPDATABLE);

			// questo sembra l'unico modo di mandare al DB la sequenza "\'"...
			String valore2 = valore.replaceAll("\'", "\\\\'");

			String query = "select " + campo + " from " + tabella;
			query += " where " + campo + " = \'" + valore2 + "\'";
			//out(query);
			ResultSet rs = stmt.executeQuery(query);
			rs.last();
			if(rs.getRow() != 1)
			{
				out("  Valore mancante: " + valore);
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

	public static void main(String[] args)
	{
		String driver = args[0];
		String url = args[1];
		String user = args[2];
		String pass = args[3];
		String xml = args[4];
		VarieQuery vq = new VarieQuery(driver, url, user, pass);
		Document doc = vq.load(new File(xml));
		try
		{
			BufferedReader conf = new BufferedReader(
					new FileReader("VarieQuery.conf"));
			while(conf.ready())
			{
				String riga = conf.readLine();
				String parti[] = riga.split(" ");
				String xpath = parti[0];
				String tabella = parti[1];
				String campo = parti[2];
				vq.out("Percorso: " + xpath);
				try
				{
					XPath xp = XPath.newInstance(xpath);
					List list = xp.selectNodes(doc);
					Set ts = new TreeSet();
					//vq.out(" " + list.size());

					// itera sulla lista dei nodi estratti dal xpath

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

					// itera sul set, quindi stessi dati, ma in ordine e senza ripetizioni
					// (e solo il contenuto)

					Iterator i = ts.iterator();
					while(i.hasNext())
					{
						String valore = (String) i.next();
						// vq.out(valore);
						vq.verificaValore(tabella, campo, valore);
					}
				}
				catch(JDOMException e)
				{
					e.printStackTrace();
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
