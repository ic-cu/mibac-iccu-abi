package xml;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigInteger;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.GregorianCalendar;

import javax.xml.bind.JAXBContext;
import javax.xml.bind.JAXBException;
import javax.xml.bind.Marshaller;

import org.jdom.Document;
import org.jdom.Element;
import org.jdom.output.Format;
import org.jdom.output.XMLOutputter;

import sql.DB;
import xml.xhtml.A;
import xml.xhtml.Body;
import xml.xhtml.Br;
import xml.xhtml.Div;
import xml.xhtml.Html;
import xml.xhtml.P;
import xml.xhtml.Table;
import xml.xhtml.Td;
import xml.xhtml.Th;
import xml.xhtml.Tr;

public class PubblicaTabelle
{
	DB db;
	BufferedReader conf;
	String confFile;

	public PubblicaTabelle(String file)
	{
		db = new DB(DB.mysqlDriver, DB.urlGauss, "abi", null);
		confFile = file;
	}

	public void openConf() throws FileNotFoundException
	{
		conf = new BufferedReader(new FileReader(confFile));
	}

	public void closeConf() throws IOException
	{
		conf.close();
	}

	public void creaXML()
	{
		try
		{

			Document t = new Document();
			Element r = new Element("liste");
			String xmlDateTimeFormat = "yyyy-MM-dd'T'HH:mm:ssZ";
			String dataExport = new SimpleDateFormat(xmlDateTimeFormat)
					.format(new GregorianCalendar().getTime());
			r.setAttribute("data-export", dataExport);
			Element temp;
			t.setRootElement(r);
			// Legge il file di configurazione una riga alla volta
			openConf();
			while(conf.ready())
			{
				String riga = conf.readLine();
				if(!riga.startsWith("#"))
				{
					String campi[] = riga.split(";");
					String xpath = campi[0];
					String tabella = campi[1];
					String campo = campi[2];
					String descrizione = campi[3];

					// si crea un nuovo elemento "lista"
					temp = new Element("lista");
					temp.setAttribute("xpath", xpath);
					temp.setAttribute("descrizione", descrizione);

					// Ora c'è tutto quello che serve per interrogare il DB
					System.out.println("Tabella " + descrizione);
					String query = "select " + campo + " from " + tabella + " order by "
							+ campo;
					ResultSet rs = db.select(query);

					// si può popolare l'elemento "lista" con gli elementi "voce"
					while(rs.next())
					{
						temp.addContent(new Element("voce").setText(rs.getString(1)));
					}

					// si aggiunge questo "tabella" a "tabelle"
					r.addContent(temp);
				}
			}
			XMLOutputter xo = new XMLOutputter(Format.getPrettyFormat());
			xo.output(t, new PrintWriter(new File("tabelle.xml")));
			closeConf();
		}
		catch(IOException e)
		{
			e.printStackTrace();
		}
		catch(SQLException e)
		{
			e.printStackTrace();
		}
	}

	public void creaCSV()
	{
		try
		{
			// Legge il file di configurazione una riga alla volta
			openConf();
			while(conf.ready())
			{
				String campi[] = conf.readLine().split(";");
				String elemento = campi[0];
				if(!elemento.startsWith("#"))
				{
					String tabella = campi[1];
					String campo = campi[2];
					String titolo = campi[3];

					// Ora c'è tutto quello che serve per interrogare il DB
					System.out
							.println("-----------\nTabella " + titolo + "\n-----------");
					String query = "select " + campo + " from " + tabella + " order by "
							+ campo;
					ResultSet rs = db.select(query);
					while(rs.next())
					{
						System.out.println(rs.getString(1));
					}
				}
			}
			closeConf();
		}
		catch(IOException e)
		{
			e.printStackTrace();
		}
		catch(SQLException e)
		{
			e.printStackTrace();
		}
	}

	public void creaHTML()
	{
		try
		{
			JAXBContext jc = null;
			Marshaller m = null;
			try
			{
				jc = JAXBContext.newInstance("xml.xhtml");
				/*
				 * unmarshal è l'azione di caricare nelle classi create un file XML
				 * secondo il formato da cui sono state create le classi stesse
				 */
				m = jc.createMarshaller();
				m.setProperty("jaxb.formatted.output", true);
			}
			catch(JAXBException e)
			{
				e.printStackTrace();
			}

			/*
			 * Vengono creati alcuni elementi HTML sotto forma di oggetti Java.
			 * Qualcuno verrà anche istanziato subito e collocato al posto giusto,
			 * qualcuno viene solo diclarato perché più avanti saranno create
			 * ciclicamente molte istanze con lo stesso nome
			 */
			Html ht = new Html();
			Body b = new Body();
			ht.setBody(b);
			A a;
			P p;

			String xmlDateTimeFormat = "yyyy-MM-dd";
			String dataExport = new SimpleDateFormat(xmlDateTimeFormat)
					.format(new GregorianCalendar().getTime());
			// Inseriamo come "p" la data di aggiornamento
			p = new P();
			p.getContent().add("Aggiornate il " + dataExport);
			b.getPOrH1OrH2().add(p);

			// Si istanzia e si colloca l'indice
			
			Div indice = new Div();
			b.getPOrH1OrH2().add(indice);
			
			Table t;

			Tr tr;
			Td td;
			Th th;
			// Legge il file di configurazione una riga alla volta
			openConf();
			while(conf.ready())
			{
				t = new Table();
				b.getPOrH1OrH2().add(new P());
				b.getPOrH1OrH2().add(t);
				String riga = conf.readLine();
				if(!riga.startsWith("#"))
				{
					String campi[] = riga.split(";");
					String xpath = campi[0];
					String tabella = campi[1];
					String campo = campi[2];
					String descrizione = campi[3];

					// si crea un nuovo elemento "table"
					// body.addContent(new Element("p"));
					t.setBorder(BigInteger.valueOf(1));

					// si crea la cella, si riempie e si aggiunge a una nuova riga
					
					th = new Th();
					a = new A();
					a.setHref("/");
					a.getContent().add(descrizione);
					a.setName(tabella);
					th.getContent().add(a);
					th.setAlign("left");
					tr = new Tr();
					tr.getThOrTd().add(th);
					
					// si aggiunge la riga alla tabella
					
					t.getTr().add(tr);
					
					// stessa cosa con l'xpath
					
					th = new Th();
					th.getContent().add("percorso: " + xpath);
					th.setAlign("left");
					tr = new Tr();
					tr.getThOrTd().add(th);
					
					// si aggiunge la riga alla tabella
					
					t.getTr().add(tr);
					
					// si popola anche l'indice
					
					indice.getContent().add(new Br());
					a = new A();
					a.getContent().add(descrizione);
					a.setHref("#" + tabella);
					indice.getContent().add(a);

					// Ora c'è tutto quello che serve per interrogare il DB
					
					System.out.println("Tabella " + descrizione);
					String query = "select " + campo + " from " + tabella + " order by "
							+ campo;
					ResultSet rs = db.select(query);

					// si può popolare l'elemento "lista" con gli elementi "voce"
					while(rs.next())
					{
						td = new Td();
						td.getContent().add(rs.getString(1));
						tr = new Tr();
						tr.getThOrTd().add(td);
						t.getTr().add(tr);
					}
				}
			}
			m.marshal(ht, new PrintWriter(new File("tabelle.html")));
			closeConf();
		}
		catch(IOException e)
		{
			e.printStackTrace();
		}
		catch(SQLException e)
		{
			e.printStackTrace();
		}
		catch(JAXBException e)
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public static void main(String[] args)
	{
		PubblicaTabelle pt = new PubblicaTabelle("PubblicaTabelle.conf");
		// pt.creaXML();
		pt.creaHTML();
		pt.creaCSV();
		pt.creaXML();
	}

}
