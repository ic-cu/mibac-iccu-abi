package xml;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.GregorianCalendar;

import org.jdom.Document;
import org.jdom.Element;
import org.jdom.output.Format;
import org.jdom.output.XMLOutputter;

import sql.DB;

public class PubblicaTabelle
{
	DB db;
	BufferedReader conf;

	public PubblicaTabelle(String file)
	{
		try
		{
			db = new DB(DB.mysqlDriver, DB.urlGauss, "abi", null);
			conf = new BufferedReader(new FileReader(file));
		}
		catch(FileNotFoundException e)
		{
			e.printStackTrace();
		}
	}

	public void creaXML()
	{
		try
		{
			Document t = new Document();
			Element r = new Element("liste");
			String xmlDateTimeFormat ="yyyy-MM-dd'T'HH:mm:ssZ";
			String dataExport = 
				new SimpleDateFormat(xmlDateTimeFormat)
				.format(new GregorianCalendar().getTime());
			r.setAttribute("data-export", dataExport);
			Element temp;
			t.setRootElement(r);
			// Legge il file di configurazione una riga alla volta
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
					System.out
							.println("Tabella " + descrizione);
					String query = 
						"select " + campo
						+ " from " + tabella
						+ " order by " + campo;
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

	public static void main(String[] args)
	{
		PubblicaTabelle pt = new PubblicaTabelle("PubblicaTabelle.conf");
		pt.creaXML();
	}

}
