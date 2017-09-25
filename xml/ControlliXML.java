package xml;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Iterator;
import java.util.Properties;
import java.util.regex.Pattern;

import javax.xml.bind.JAXBContext;
import javax.xml.bind.JAXBException;
import javax.xml.bind.Unmarshaller;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.xpath.XPath;
import javax.xml.xpath.XPathConstants;
import javax.xml.xpath.XPathExpression;
import javax.xml.xpath.XPathExpressionException;
import javax.xml.xpath.XPathFactory;

import org.w3c.dom.Document;
import org.w3c.dom.NodeList;
import org.xml.sax.SAXException;

import util.log.Log;
import util.sql.DB;
import xml.xsd.v16.AnagraficaType.Contatti.Altri.Altro;
import xml.xsd.v16.BibliotecaType;
import xml.xsd.v16.Biblioteche;

public class ControlliXML
{

	private Properties config;
	private PreparedStatement qAICE;
	private PreparedStatement qStatoCat;
	private String qValori;
	private DB db;
	private JAXBContext jc;
	private XPathExpression expr;
	private XPath xpath;
	private XPathFactory xPathFactory;
	private Document doc;
	private DocumentBuilder docBuilder;
	private DocumentBuilderFactory docBuilderFactory;

	public ControlliXML(String prop)
	{
		config = new Properties();
		try
		{
			config.load(new FileReader(prop));
			String driver = config.getProperty("db.driver");
			Log.debug(driver);
			String url = config.getProperty("db.url");
			String username = config.getProperty("db.username");
			String password = config.getProperty("db.password");
			db = new DB(driver, url, username, password);
			qAICE = db.prepare(config.getProperty("query.aice"));
			qStatoCat = db.prepare(config.getProperty("query.statocat"));
			qValori = config.getProperty("query.valori");

/*
 * Il JAXBContext è il punto di partenza. La stringa deve riprodurre esattamente
 * il package contenente tutte le classi generate dal compilatore XJC
 */
			jc = JAXBContext.newInstance("xml.xsd.v16");

/*
 * Istanzia il builder che permetterà di caricare un documento XML
 */
			docBuilderFactory = DocumentBuilderFactory.newInstance();
			docBuilder = docBuilderFactory.newDocumentBuilder();

/*
 * Inizializza quanto serve a cercare liste di nodi o attributi nel file XML
 */
			xPathFactory = XPathFactory.newInstance();
			xpath = xPathFactory.newXPath();
		}
		catch(FileNotFoundException e)
		{
			Log.error(e.getMessage());
		}
		catch(IOException e)
		{
			Log.error(e.getMessage());
		}
		catch(JAXBException e)
		{
			Log.error(e.getMessage());
		}
		catch(ParserConfigurationException e)
		{
			e.printStackTrace();
		}
	}

	/*
	 * Carica un file XML conforme al formato 1.5
	 */

	public Biblioteche carica(File f)
	{
		Biblioteche biblioteche = null;
		Unmarshaller u = null;
		try
		{
			/*
			 * unmarshal è l'azione di caricare nelle classi create un file XML
			 * secondo il formato da cui sono state create le classi stesse
			 */
			u = jc.createUnmarshaller();
			biblioteche = (Biblioteche) u.unmarshal(f);
		}
		catch(JAXBException e)
		{
			e.printStackTrace();
		}

		return biblioteche;

	}

	// Costruttore con nome di file
	public Biblioteche carica(String fn)
	{
		return carica(new File(fn));
	}

	public void lista(Biblioteche b)
	{
		/*
		 * Estrae codici e denominazioni di ogni biblioteca
		 */
		Iterator<BibliotecaType> i = b.getBiblioteca().iterator();
		while(i.hasNext())
		{
			BibliotecaType bib = (BibliotecaType) i.next();
			System.out.print(bib.getAnagrafica().getCodici().getIsil() + " " + bib.getAnagrafica().getNomi().getAttuale());
			Iterator<Altro> i2 = (bib.getAnagrafica().getContatti().getAltri().getAltro()).iterator();
			while(i2.hasNext())
			{
				Altro aca = i2.next();
				if(aca.getTipo().equals("e-mail"))
				{
					System.out.print(" [" + aca.getValore() + "]");
					if(aca.getNote() != null)
					{
						System.out.print(" (" + aca.getNote() + ") ");
					}
				}
			}
			System.out.println();
		}
	}

	/*
	 * Un ovvio test sulla validità dei codici ISIL
	 */
	public void isil(Biblioteche b)
	{
		Iterator<BibliotecaType> i = b.getBiblioteca().iterator();
		while(i.hasNext())
		{
			BibliotecaType bib = (BibliotecaType) i.next();
			String isil = bib.getAnagrafica().getCodici().getIsil();

			/*
			 * se manca il prefisso, lo mettiamo, così i controlli seguenti si fanno
			 * una volta sola; il codice viene anche corretto nei dati, così esce
			 * nell'XML, se uno decide di estrarlo
			 */
			if(!isil.startsWith("IT-"))
			{
				isil = "IT-" + isil;
				bib.getAnagrafica().getCodici().setIsil(isil);
			}
			if(isil.length() != 9)
			{
				Log.warn(isil + " *** codice di lunghezza errata ***");
			}
			else
			{
				if(!Pattern.matches("IT-[a-zA-Z]{2}[0-9]{4}", isil))
				{
					Log.warn(isil + " *** codice mal formato ***");
				}
			}
		}
	}

	/*
	 * Controlla che le biblioteche da importare abbiano o meno un codice CEI
	 */
	public void fonteAICE(Biblioteche b)
	{
		Log.info("Verifica eventuale fonte AICE");
		ResultSet rs = null;
		Iterator<BibliotecaType> i = b.getBiblioteca().iterator();
		while(i.hasNext())
		{
			BibliotecaType bib = (BibliotecaType) i.next();
			String isil = bib.getAnagrafica().getCodici().getIsil();
			Log.debug("Controllo " + isil);
			try
			{
				qAICE.setString(1, isil);
				rs = qAICE.executeQuery();
				if(rs.next())
				{
					if(rs.getString(1) != null)
					{
						if(!rs.getString(1).toLowerCase().equals("null"))
						{
							if(rs.getString(1).length() != 0)
							{
								Log.warn(isil + " ha fonte AICE");
							}
						}
					}
				}
			}
			catch(SQLException e)
			{
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}

	public void statoCat(Biblioteche b)
	{
		Log.info("Verifica eventuale stato di catalogazione");
		ResultSet rs = null;
		Iterator<BibliotecaType> i = b.getBiblioteca().iterator();
		while(i.hasNext())
		{
			BibliotecaType bib = (BibliotecaType) i.next();
			String isil = bib.getAnagrafica().getCodici().getIsil();
			Log.debug("Controllo " + isil);
			try
			{
				qStatoCat.setString(1, isil);
				rs = qStatoCat.executeQuery();
				if(rs.next())
				{
					if(rs.getString("isil") != null)
					{
						if(!rs.getString("isil").toLowerCase().equals("null"))
						{
							if(rs.getString("isil").length() != 0)
							{
								Log.warn(isil + ": " + rs.getString("stato"));
							}
						}
					}
				}
			}
			catch(SQLException e)
			{
				e.printStackTrace();
			}
		}
	}

/*
 * Estrazione di tutti i valori di una serie di elementi e eattributi e verifica
 * della loro esistenza nella base dati
 */
	public void valori(String input)
	{
		try
		{
			Log.info("Verifica voci d'autorità");
			doc = docBuilder.parse(input);
			BufferedReader conf;
			conf = new BufferedReader(new FileReader(config.getProperty("xpath.map")));
			NodeList nl;
			PreparedStatement stmt;
			while(conf.ready())
			{
				String[] parti = conf.readLine().split(" ");
				String path = parti[0];
				String tabella = parti[1];
				String campo = parti[2];
				if(!path.startsWith("#"))
				{
					expr = xpath.compile(path);
					nl = (NodeList) expr.evaluate(doc, XPathConstants.NODESET);
					stmt = db.prepare(String.format(qValori, campo, tabella, campo));
					Log.info(path);
					for(int i = 0; i < nl.getLength(); i++)
					{
						String valore = nl.item(i).getTextContent();
						stmt.setString(1, valore);
						Log.debug(valore);
						Log.debug(stmt.toString());
						ResultSet rs = stmt.executeQuery();
						rs.last();
						if(rs.getRow() < 1)
						{
							Log.warn(valore + " mancante");
						}
						if(rs.getRow() > 1)
						{
							Log.warn("Il valore " + valore + " è duplicato nel DB");
						}
					}
				}
			}
			conf.close();
		}
		catch(SAXException e)
		{
			e.printStackTrace();
		}
		catch(IOException e)
		{
			e.printStackTrace();
		}
		catch(XPathExpressionException e)
		{
			e.printStackTrace();
		}
		catch(SQLException e)
		{
			e.printStackTrace();
		}
	}
}