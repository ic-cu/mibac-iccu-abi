package opendata;

import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.Properties;

import org.jdom.Document;
import org.jdom.Element;
import org.jdom.output.Format;
import org.jdom.output.XMLOutputter;

import sql.DB;

public class OpenData
{
	private DB db;
	private Properties config;

	private void err(String str)
	{
		System.err.println(str);
	}

	private void out(String str)
	{
		System.out.println(str);
	}

	public OpenData()
	{
		config = new Properties();
		try
		{
			config.load(new FileReader("opendata.prop"));
		}
		catch(FileNotFoundException e)
		{
			err("File di configurazione non trovato: " + e.getMessage());
		}
		catch(IOException e)
		{
			err("Impossibile leggere il file di configurazione: " + e.getMessage());
		}
		String url = config.getProperty("db.url");
		String user = config.getProperty("db.user");
		String pass = config.getProperty("db.pass");
		db = new DB(DB.mysqlDriver, url, user, pass);
	}

	public String territorio()
	{
		String query = config.getProperty("territorio.query");
		ResultSet rs = db.select(query);
		ResultSetMetaData rsmd;
		StringWriter output = new StringWriter();
		PrintWriter pw;
		try
		{
			pw = new PrintWriter(output);
			rsmd = rs.getMetaData();
			int columns = rsmd.getColumnCount();
			int i;
			String header = "";
			String row = "";
			String cell = "";
			for(i = 1; i < columns; i++)
			{
				header += rsmd.getColumnLabel(i) + ";";
			}
			header += rsmd.getColumnLabel(i);
			pw.println(header);
			while(rs.next())
			{
				row = "";
				for(i = 1; i < columns; i++)
				{
					cell = rs.getString(i);
					if(cell == null)
					{
						cell = "";
					}
					row += cell + ";";
				}
				row += rs.getString(i);
				pw.println(row);
			}
			pw.close();
		}
		catch(SQLException e)
		{
			err("Errore SQL: " + e.getMessage());
		}
		return output.getBuffer().toString();
	}

	public Document patrimonio()
	{
		ResultSet bibs;
		ResultSet bib;
		PreparedStatement patrimonioStmt;
		patrimonioStmt = db.prepare(config.getProperty("patrimonio.query"));
		bibs = db.select(config.getProperty("censite.query"));
		String isil, nome, categoria;
		int totalePosseduto, acquistiUltimoAnno;
		Document doc = new Document();
		Element root = new Element("biblioteche");
		Element biblioteca;
		Element patrimonioElement;
		doc.setRootElement(root);
		int limit = Integer.MAX_VALUE;
		try
		{
			limit = Integer.parseInt(config.getProperty("censite.limit"));
		}
		catch(NumberFormatException e)
		{
			err("Massimo numero di biblioteche da elaborare ignorato, si userà il massimo intero possibile");
		}
		try
		{
			while(bibs.next() && limit > 0)
			{
				limit--;
				isil = bibs.getString("isil");
				biblioteca = new Element("biblioteca");
				biblioteca.setAttribute("isil", isil);
				patrimonioStmt.setString(1, isil);
				bib = patrimonioStmt.executeQuery();
				boolean ok = false;
				while(bib.next())
				{
					ok = true;
					nome = bib.getString("nome");
					categoria = bib.getString("categoria");
					totalePosseduto = bib.getInt("quantita");
					acquistiUltimoAnno = bib.getInt("acquisti-ultimo-anno");
					err(nome);
					patrimonioElement = new Element("materiale");
					patrimonioElement.setAttribute("categoria", categoria);
					if(totalePosseduto != 0)
					{
						patrimonioElement.setAttribute("posseduto", "" + totalePosseduto);
					}
					if(acquistiUltimoAnno != 0)
					{
						patrimonioElement.setAttribute("acquisti-ultimo-anno", ""
								+ acquistiUltimoAnno);
					}
					patrimonioElement.setText(nome);
					biblioteca.addContent(patrimonioElement);
				}
				if(ok) root.addContent(biblioteca);
			}
		}
		catch(SQLException e)
		{
			e.printStackTrace();
		}
		return doc;
	}

	public Document fondiSpeciali()
	{
		ResultSet bibs;
		ResultSet bib;
		PreparedStatement stmt;
		stmt = db.prepare(config.getProperty("fondi-speciali.query"));
		bibs = db.select(config.getProperty("censite.query"));
		String isil, nome, descrizione, dewey, deweyTesto;
		Document doc = new Document();
		Element root = new Element("biblioteche");
		Element biblioteca;
		Element element;
		doc.setRootElement(root);
		int limit = Integer.MAX_VALUE;
		try
		{
			limit = Integer.parseInt(config.getProperty("censite.limit"));
		}
		catch(NumberFormatException e)
		{
			err("Massimo numero di biblioteche da elaborare ignorato, si userà il massimo intero possibile");
		}
		try
		{
			while(bibs.next() && limit > 0)
			{
				limit--;
				isil = bibs.getString("isil");
				biblioteca = new Element("biblioteca");
				biblioteca.setAttribute("isil", isil);
				stmt.setString(1, isil);
				bib = stmt.executeQuery();
				boolean ok = false;
				while(bib.next())
				{
					ok = true;
					nome = bib.getString("nome");
					descrizione = bib.getString("descrizione");
					dewey = bib.getString("dewey");
					deweyTesto = bib.getString("dewey-testo");
					err(nome);
					element = new Element("fondo-speciale");
					if(descrizione != null && descrizione.trim() != "")
					{
						element.addContent(new Element("descrizione").setText(descrizione.trim()));
					}
					if(dewey != null && dewey.trim() != "")
					{
						if(dewey.length() > 3)
						{
							dewey = dewey.substring(0,3) + "." + dewey.substring(3);
						}
						Element deweyE = new Element("dewey");
						deweyE.setAttribute("codice", dewey);
						deweyE.setText(deweyTesto.trim());
						element.addContent(deweyE);
					}
					biblioteca.addContent(element);
				}
				if(ok) root.addContent(biblioteca);
			}
		}
		catch(SQLException e)
		{
			e.printStackTrace();
		}
		return doc;
	}

	public Document contatti()
	{
		ResultSet bibs;
		ResultSet bib;
		PreparedStatement contattiStmt;
		contattiStmt = db.prepare(config.getProperty("contatti.query"));
		bibs = db.select(config.getProperty("censite.query"));
		String isil, contatto, tipo, note;
		Document doc = new Document();
		Element root = new Element("biblioteche");
		Element biblioteca;
		Element contattoElement;
		doc.setRootElement(root);
		int limit = Integer.MAX_VALUE;
		try
		{
			limit = Integer.parseInt(config.getProperty("censite.limit"));
		}
		catch(NumberFormatException e)
		{
			err("Massimo numero di biblioteche da elaborare ignorato, si userà il massimo intero possibile");
		}
		try
		{
			while(bibs.next() && limit > 0)
			{
				limit--;
				isil = bibs.getString("isil");
				biblioteca = new Element("biblioteca");
				biblioteca.setAttribute("isil", isil);
				contattiStmt.setString(1, isil);
				bib = contattiStmt.executeQuery();
				boolean ok = false;
				while(bib.next())
				{
					ok = true;
					contatto = bib.getString("contatto");
					tipo = bib.getString("tipo");
					note = bib.getString("note");
					err(contatto);
					contattoElement = new Element("contatto");
					contattoElement.setAttribute("tipo", tipo.toLowerCase());
					if(note != null && note.trim() != "")
					{
						contattoElement.setAttribute("note", note.trim());
					}
					contattoElement.setText(contatto.trim());
					biblioteca.addContent(contattoElement);
				}
				if(ok) root.addContent(biblioteca);
			}
		}
		catch(SQLException e)
		{
			e.printStackTrace();
		}
		return doc;
	}

	public static void main(String[] args)
	{
		OpenData od = new OpenData();
		od.out("Creazione file in formati open data");
		try
		{
			XMLOutputter xo = new XMLOutputter(Format.getPrettyFormat());
			if(od.config.getProperty("territorio") != null)
			{
				PrintWriter territorioPW = new PrintWriter(
						od.config.getProperty("territorio.file"));
				territorioPW.println(od.territorio());
				territorioPW.close();
			}
			if(od.config.getProperty("contatti") != null)
			{
				Document contatti = od.contatti();
				xo.output(contatti,
						new FileWriter(od.config.getProperty("contatti.file")));
			}
			if(od.config.getProperty("patrimonio") != null)
			{
				Document patrimonio = od.patrimonio();
				xo = new XMLOutputter(Format.getPrettyFormat());
				xo.output(patrimonio,
						new FileWriter(od.config.getProperty("patrimonio.file")));
			}
			if(od.config.getProperty("fondi-speciali") != null)
			{
				Document fondiSpeciali = od.fondiSpeciali();
				xo = new XMLOutputter(Format.getPrettyFormat());
				xo.output(fondiSpeciali,
						new FileWriter(od.config.getProperty("fondi-speciali.file")));
			}
		}
		catch(FileNotFoundException e)
		{
			od.err("File non trovato: " + e.getMessage());
		}
		catch(IOException e)
		{
			od.err("Errore di I/O: " + e.getMessage());
		}
		catch(NullPointerException e)
		{
			od.err("Puntatore nullo: " + e.getMessage());
		}
	}
}
