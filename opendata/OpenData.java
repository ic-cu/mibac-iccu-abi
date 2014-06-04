package opendata;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.Properties;
import java.util.zip.ZipEntry;
import java.util.zip.ZipException;
import java.util.zip.ZipOutputStream;

import org.jdom.Document;
import org.jdom.Element;
import org.jdom.output.Format;
import org.jdom.output.XMLOutputter;

import org.apache.log4j.Level;
import org.apache.log4j.Logger;
import org.apache.log4j.PatternLayout;
import org.apache.log4j.WriterAppender;

import sql.DB;

public class OpenData
{
	private DB db;
	private Properties config;
	private String today;
	private String tempDir;
	private String csvSep;
	private Logger log;
	private static String	logLayout	= "%05r %p %C{1}.%M - %m%n";
	
	private void err(String str)
	{
		System.err.println(str);
	}

	private void out(String str)
	{
		System.out.println(str);
	}

	private void initLogger() throws FileNotFoundException
	{
		// logger generico
		log = Logger.getLogger("OPENDATA");
		log.setLevel(Level.INFO);
		PatternLayout pl = new PatternLayout(logLayout);
		File lf = new File(config.getProperty("log.file"));
		PrintWriter pw = new PrintWriter(lf);
		WriterAppender wa = new WriterAppender(pl, pw);
		log.addAppender(wa);
		wa = new WriterAppender(pl, System.out);
		log.addAppender(wa);
		// BasicConfigurator.configure(wa);
	}


	public OpenData()
	{
		config = new Properties();
		try
		{
			config.load(new FileReader("opendata.prop"));
			initLogger();
		}
		catch(FileNotFoundException e)
		{
			log.warn("File non trovato: " + e.getMessage());
		}
		catch(IOException e)
		{
			err("Impossibile leggere il file di configurazione: " + e.getMessage());
		}
		String url = config.getProperty("db.url");
		String user = config.getProperty("db.user");
		String pass = config.getProperty("db.pass");
		db = new DB(DB.mysqlDriver, url, user, pass);

		SimpleDateFormat sdf;
		sdf = new SimpleDateFormat("yyyyMMdd");
		today = sdf.format(new Date());

		tempDir = config.getProperty("temp.dir") + "/" + today;
		File tDir = null;
		tDir = new File(tempDir);
		tDir.mkdirs();

		csvSep = config.getProperty("csv.fs");
		log.info("Separatore campi per formato CSV [" + csvSep + "]");
	}

	public String territorio()
	{
		String query = config.getProperty("territorio.query");
		err(query);
		ResultSet bib;
		ResultSetMetaData rsmd;
		StringWriter output = new StringWriter();
		PrintWriter pw;
		String isil = "", row = null, cell, contatto, note;
		String tel = "", fax = "", mail = "", url = "";
		String oldIsil = "";
		int tipo;
		int limit = Integer.MAX_VALUE;
		int columns = 0;
		int i;
		try
		{
			limit = Integer.parseInt(config.getProperty("censite.limit"));
		}
		catch(NumberFormatException e)
		{
			log.info("Massimo numero di biblioteche da elaborare ignorato, si userà il massimo intero possibile");
		}
		try
		{
			boolean headerOk = false;
			pw = new PrintWriter(output);
			bib = db.select(query);
			while(bib.next() && limit-- > 0)
			{
				isil = bib.getString(1);
				try
				{

					// una sola volta si crea l'header
					if(!headerOk)
					{
						rsmd = bib.getMetaData();
						columns = rsmd.getColumnCount() - 3;
						String header = "";
						row = "";
						cell = "";
						for(i = 1; i < columns; i++)
						{
							header += rsmd.getColumnLabel(i) + csvSep;
						}
						header += rsmd.getColumnLabel(i) + csvSep;

						// si aggiungono all'header quattro campi che saranno riempiti in
						// base ai tipi di contatti rinvenuti

						header += "telefono" + csvSep;
						header += "fax" + csvSep;
						header += "email" + csvSep;
						header += "url";
						pw.println(header);
						headerOk = true;
					}

					if(!isil.equals(oldIsil))
					{
						if(oldIsil != "")
						{
							row += tel + csvSep + fax + csvSep + mail + csvSep + url;
							pw.println(row);
							pw.flush();
						}
						row = "";
						for(i = 1; i < columns; i++)
						{
							cell = bib.getString(i);
							if(cell == null)
							{
								cell = "";
							}
							row += cell.trim() + csvSep;
						}
						row += bib.getString(i) + csvSep;
						oldIsil = isil;
						tel = fax = mail = url = "";
					}

					// vanno gestiti i possibili contatti
					contatto = bib.getString("contatto");

					note = bib.getString("note");
					tipo = bib.getInt("tipo");
					if(contatto != null)
					{
						contatto = contatto.trim();
						if(note == null || note.trim() == "")
						{
							/*
							 * i contatti vanno selezionati per codice, perché il right join
							 * non funziona se si estraggono anche i codici e le descrizioni
							 */
							switch(tipo)
							{
								case 1:
									// telefono
									if(tel == "") tel = contatto;
									err("tel");
									break;
								case 2:
									// fax
									if(fax == "") fax = contatto;
									err("fax");
									break;
								case 3:
									// mail
									if(mail == "") mail = contatto;
									err("mail");
									break;
								case 5:
									// url
									if(url == "") url = contatto;
									err("url");
									break;
								default:
									break;
							}
						}
					}
				}
				catch(SQLException e)
				{
					log.error("Errore SQL: " + e.getMessage());
				}
			}
			pw.close();
		}
		catch(SQLException e)
		{
			log.error("Errore SQL: " + e.getMessage());
		}
		return output.getBuffer().toString();
	}

	public Document patrimonio()
	{
		ResultSet bibs;
		ResultSet bib;
		PreparedStatement stmt;
		stmt = db.prepare(config.getProperty("patrimonio.query"));
		bibs = db.select(config.getProperty("censite.query"));
		String isil, denominazione, nome, categoria;
		int totalePosseduto, acquistiUltimoAnno;
		int idBib;
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
			log.info("Massimo numero di biblioteche da elaborare ignorato, si userà il massimo intero possibile");
		}
		try
		{
			while(bibs.next() && limit > 0)
			{
				limit--;
				isil = bibs.getString("isil");
				idBib = bibs.getInt("id");
				denominazione = bibs.getString("denominazione");
				biblioteca = new Element("biblioteca");
				biblioteca.setAttribute("isil", isil);
				biblioteca.setAttribute("denominazione", denominazione);
				stmt.setInt(1, idBib);
				bib = stmt.executeQuery();
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
						element.addContent(new Element("descrizione").setText(descrizione
								.trim()));
					}
					if(dewey != null && dewey.trim() != "")
					{
						if(dewey.length() > 3)
						{
							dewey = dewey.substring(0, 3) + "." + dewey.substring(3);
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
		PreparedStatement stmt;
		stmt = db.prepare(config.getProperty("contatti.query"));
		err(config.getProperty("censite.query"));
		bibs = db.select(config.getProperty("censite.query"));
		String isil, denominazione, contatto, tipo, note;
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
				denominazione = bibs.getString("denominazione");
				biblioteca = new Element("biblioteca");
				biblioteca.setAttribute("isil", isil);
				biblioteca.setAttribute("denominazione", denominazione);
				stmt.setString(1, isil);
				bib = stmt.executeQuery();
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

	public String tipologie()
	{
		String query = config.getProperty("tipologie.query");
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
					row += cell.trim() + ";";
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

	public Document dewey()
	{
		ResultSet bibs;
		ResultSet bib;
		PreparedStatement stmt;
		stmt = db.prepare(config.getProperty("specializzazioni.query"));
		bibs = db.select(config.getProperty("censite.query"));
		String isil, dewey, deweyTesto;
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
				err(isil);
				bib = stmt.executeQuery();
				boolean ok = false;
				while(bib.next())
				{
					ok = true;
					dewey = bib.getString("codice");
					deweyTesto = bib.getString("dewey-testo");
					element = new Element("specializzazione");
					if(dewey != null && dewey.trim() != "")
					{
						if(dewey.length() > 3)
						{
							dewey = dewey.substring(0, 3) + "." + dewey.substring(3);
						}
						element.setAttribute("codice", dewey);
						element.setText(deweyTesto.trim());
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

	public void zip(String fileName)
	{
		FileOutputStream fos = null;
		ZipOutputStream zos = null;
		ZipEntry ze;
		FileInputStream fis;
		BufferedInputStream bis = null;

		String zipFileName = fileName.substring(0, fileName.indexOf(".")) + ".zip";
		try
		{
			fos = new FileOutputStream(tempDir + "/" + zipFileName);
			zos = new ZipOutputStream(fos);
			byte[] data = new byte[2048];
			ze = new ZipEntry(fileName);
			fis = new FileInputStream(tempDir + "/" + fileName);
			bis = new BufferedInputStream(fis, 2048);
			zos.putNextEntry(ze);
			int count;
			while((count = bis.read(data, 0, 2048)) != -1)
			{
				zos.write(data, 0, count);
				zos.flush();
			}
			zos.closeEntry();

		}
		catch(NullPointerException e)
		{

		}
		catch(FileNotFoundException e)
		{
			e.printStackTrace();
		}
		catch(IOException e)
		{
			e.printStackTrace();
		}

		try
		{
			bis.close();
			zos.flush();
			zos.close();
			fos.close();
		}
		catch(ZipException e)
		{
			// e.printStackTrace();
		}
		catch(IOException e)
		{
			e.printStackTrace();
		}

	}

	public static void main(String[] args)
	{
		OpenData od = new OpenData();
		od.out("Creazione file in formati open data");
		GregorianCalendar gc = new GregorianCalendar();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss");
		od.err(sdf.format(gc.getTime()));
		System.gc();
		try
		{
			XMLOutputter xo = new XMLOutputter(Format.getPrettyFormat());
			Document doc;
			PrintWriter pw;
			String tDir = od.tempDir + "/";
			String tFile;
			if(od.config.getProperty("territorio") != null)
			{
				tFile = od.config.getProperty("territorio.file");
				pw = new PrintWriter(tDir + tFile);
				pw.println(od.territorio());
				pw.close();
				od.zip(tFile);
			}
			if(od.config.getProperty("contatti") != null)
			{
				doc = od.contatti();
				tFile = od.config.getProperty("contatti.file");
				pw = new PrintWriter(tDir + tFile);
				xo.output(doc, pw);
				od.zip(tFile);
			}
			if(od.config.getProperty("patrimonio") != null)
			{
				doc = od.patrimonio();
				tFile = od.config.getProperty("patrimonio.file");
				pw = new PrintWriter(tDir + tFile);
				xo.output(doc, pw);
				od.zip(tFile);
			}
			if(od.config.getProperty("fondi-speciali") != null)
			{
				doc = od.fondiSpeciali();
				tFile = od.config.getProperty("fondi-speciali.file");
				pw = new PrintWriter(tDir + tFile);
				xo.output(doc, pw);
				od.zip(tFile);
			}
			if(od.config.getProperty("tipologie") != null)
			{
				tFile = od.config.getProperty("tipologie.file");
				pw = new PrintWriter(tDir + tFile);
				pw.println(od.tipologie());
				pw.close();
				od.zip(tFile);
			}
			if(od.config.getProperty("specializzazioni") != null)
			{
				doc = od.dewey();
				tFile = od.config.getProperty("specializzazioni.file");
				pw = new PrintWriter(tDir + tFile);
				xo.output(doc, pw);
				od.zip(tFile);
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
		// catch(NullPointerException e)
		// {
		// od.err("Puntatore nullo: " + e.getMessage());
		// }
		od.err(sdf.format(gc.getTime()));
	}
}
