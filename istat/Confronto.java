/**
 * Pacchetto per il confronto fra le tabelle ISTAT dei comuni e la base dati
 * Anagrafe
 */

package istat;

import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Iterator;
import java.util.Properties;
import java.util.TreeSet;

import org.apache.log4j.Level;
import org.apache.log4j.Logger;
import org.apache.log4j.PatternLayout;
import org.apache.log4j.WriterAppender;
import org.odftoolkit.simple.SpreadsheetDocument;
import org.odftoolkit.simple.table.Row;
import org.odftoolkit.simple.table.Table;

import sql.DB;

public class Confronto
{
	private SpreadsheetDocument spComuni, spSoppressi;
	private TreeSet<String> setIntrusi;
	private Properties config;
	private static Logger log;
	private static DB db;
	private PreparedStatement qComune;
	private PreparedStatement qIstat;
	private PreparedStatement qTutti; 
	private PrintWriter outDiversi;
	private PrintWriter outMancanti;
	private PrintWriter outSoppressi;
	private PrintWriter outIntrusi;
	private int colISTAT, colNome, colProvincia;
	private int colFinanze, colName ;

	private void initLogger()
	{
		PatternLayout pl;
		PrintWriter pw = null;
		WriterAppender wa;
		log = Logger.getLogger("CONFRONTO");
		log.setLevel(Level.INFO);
		pl = new PatternLayout(config.getProperty("log.pattern"));

/*
 * La prima istruzione serve sostanzialmente a disabilitare il logging interno
 * del pacchetto ODFtoolkit, molto seccante e di solito superfluo. Poi viene
 * creato, se possibile, il file di log per l'applicazione
 */
		try
		{
			java.util.logging.LogManager.getLogManager().readConfiguration(
					new java.io.ByteArrayInputStream("org.odftoolkit.level=WARNING".getBytes(java.nio.charset.StandardCharsets.UTF_8)));
			pw = new PrintWriter(config.getProperty("log.file"));
		}
		catch(FileNotFoundException e)
		{
			System.err.println("File di log " + " non trovato: " + e.getMessage());
		}
		catch(SecurityException e)
		{
			e.printStackTrace();
		}
		catch(IOException e)
		{
			e.printStackTrace();
		}
		wa = new WriterAppender(pl, pw);
		log.addAppender(wa);
		wa = new WriterAppender(pl, System.out);
		log.addAppender(wa);
	}

/*
 * Costruttore che configura il logging e poco altro
 */

	public Confronto()
	{
		config = new Properties();
		try
		{
			config.load(new FileReader("istat/confronto.prop"));
			initLogger();
			log.info("Inizializzo confronto...");
			spComuni = SpreadsheetDocument.loadDocument(config.getProperty("ods.input.comuni"));
			spSoppressi = SpreadsheetDocument.loadDocument(config.getProperty("ods.input.soppressi"));
			log.info("Caricamento input terminato...");
			db = new DB(DB.urlGauss, "abi", "");
			qComune = db.prepare(config.getProperty("query.comune"));
			qIstat = db.prepare(config.getProperty("query.istat"));
			qTutti = db.prepare(config.getProperty("query.tutti"));
			outDiversi = new PrintWriter(config.getProperty("output.diversi"));
			outMancanti = new PrintWriter(config.getProperty("output.mancanti"));
			outSoppressi = new PrintWriter(config.getProperty("output.soppressi"));
			outIntrusi = new PrintWriter(config.getProperty("output.intrusi"));
			colISTAT = Integer.parseInt(config.getProperty("ods.col.istat"));
			colFinanze= Integer.parseInt(config.getProperty("ods.col.finanze"));
			colNome = Integer.parseInt(config.getProperty("ods.col.nome"));
			colName = Integer.parseInt(config.getProperty("ods.col.name"));
			colProvincia = Integer.parseInt(config.getProperty("ods.col.pr"));
			setIntrusi = new TreeSet<String>();
		}
		catch(IOException e)
		{
			e.printStackTrace();
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
	}

	public void free()
	{
		outDiversi.flush();
		outDiversi.close();
		outMancanti.flush();
		outMancanti.close();
		outSoppressi.flush();
		outSoppressi.close();
		outIntrusi.flush();
		outIntrusi.close();
	}
	
	public void confronta()
	{

/*
 * Cicla sulle righe del primo foglio. L'unico modo per non andare in loop
 * infinito sulle righe è vedere se la prima cella di una riga è vuota, almeno
 * in questo caso. Altrimenti si ferma dopo 1MB di righe.
 */
		Table table = spComuni.getSheetByIndex(0);
		Iterator<Row> rows = table.getRowIterator();
		outDiversi.println("istat	abi	finanze	comune	provinciaIstat	provinciaABI");
		outMancanti.println("istat	finanze	comune istat	comune abi");
		while(rows.hasNext())
		{
			Row row = rows.next();
			if(row.getCellByIndex(0).getStringValue().equals("")) break;
			String istatIstat = row.getCellByIndex(colISTAT).getStringValue();
			if(istatIstat.startsWith("Codice")) continue;
			String finanzeIstat = row.getCellByIndex(colFinanze).getStringValue();
			String nomeIstat = row.getCellByIndex(colNome).getStringValue();
			String nameIstat = row.getCellByIndex(colName).getStringValue();
			String provinciaIstat = row.getCellByIndex(colProvincia).getStringValue();
			log.debug(istatIstat + "	" + nomeIstat);
			if(!nameIstat.equals("")) nomeIstat += "." + nameIstat;
			setIntrusi.add(istatIstat);
			try
			{
				qComune.setString(1, nomeIstat);
				qComune.setString(2, provinciaIstat);
				ResultSet rs = qComune.executeQuery();
				if(rs.next())
				{
					do
					{
						String istatAbi = rs.getString(1);
						if(!istatAbi.equals(istatIstat))
						{
							outDiversi.println(istatIstat + "	" + rs.getString(1) + "	" + finanzeIstat + "	" + rs.getString(2) + "	" + provinciaIstat + "	" + rs.getString(3));
						}
					}
					while(rs.next());
				}
				else
				{
					qIstat.setString(1, istatIstat);
					ResultSet rs2 = qIstat.executeQuery();
					if(rs2.next())
					{
						do
						{
							String comuneAbi = rs2.getString(2);
							outMancanti.println(istatIstat + "	" + finanzeIstat + "	" + nomeIstat + "	" + comuneAbi);
						}
						while(rs2.next());
					}
					else
					{
						outMancanti.println(istatIstat + "	" + finanzeIstat + "	" + nomeIstat + "	" + null);
					}
				}
			}
			catch(SQLException e)
			{
				e.printStackTrace();
			}
		}
	}
	
	public void soppressi()
	{
		Table table = spSoppressi.getSheetByIndex(0);
		Iterator<Row> rows = table.getRowIterator();
		outSoppressi.println("istat	abi	comune	provincia	");
		while(rows.hasNext())
		{
			Row row = rows.next();
			if(row.getCellByIndex(0).getStringValue().equals("")) break;
			String istatIstat = row.getCellByIndex(1).getStringValue();
			String nomeIstat = row.getCellByIndex(2).getStringValue();
			String provinciaIstat = row.getCellByIndex(3).getStringValue();
			if(istatIstat.startsWith("Codice")) continue;
			try
			{
				nomeIstat.replaceFirst("/", ".");
				qComune.setString(1, nomeIstat);
				qComune.setString(2, provinciaIstat);
				ResultSet rs = qComune.executeQuery();
				if(rs.next())
				{
					do
					{
						String istatAbi = rs.getString(1);
						outSoppressi.println(istatIstat + "	" + istatAbi + "	" + nomeIstat + "	" + provinciaIstat);
					}
					while(rs.next());
				}
			}
			catch(SQLException e)
			{
				e.printStackTrace();
			}
		}		
	}

	public void intrusi()
	{
		ResultSet rs;
		try
		{
			rs = qTutti.executeQuery();
			while(rs.next())
			{
				String istat = rs.getString(1);
				String comune = rs.getString(2);
				if(! setIntrusi.contains(istat))
				{
					outIntrusi.println(istat + "	" + comune);
				}
			}
		}
		catch(SQLException e)
		{
			e.printStackTrace();
		}
	}
	
	public static void main(String[] args)
	{
		Confronto c = new Confronto();
		c.confronta();
		c.soppressi();
		c.intrusi();
		c.free();
	}
}
