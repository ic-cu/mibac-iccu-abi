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
	private SpreadsheetDocument input;
	private Properties config;
	private static Logger log;
	private static DB db;
	private PreparedStatement qComune;
	private PreparedStatement qIstat;
	private PrintWriter outDiversi;
	private PrintWriter outMancanti;
	private int colCodiceComune, colNomeComune, colNomeProvincia;
	private int colCodiceFinanze; 

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
			input = SpreadsheetDocument.loadDocument(config.getProperty("ods.input"));
			log.info("Caricamento input terminato...");
			db = new DB(DB.urlGauss, "abi", "");
			qComune = db.prepare(config.getProperty("query.comune"));
			qIstat = db.prepare(config.getProperty("query.istat"));
			outDiversi = new PrintWriter(config.getProperty("output.diversi"));
			outMancanti = new PrintWriter(config.getProperty("output.mancanti"));
			colCodiceComune = Integer.parseInt(config.getProperty("ods.col.codice.comune"));
			colCodiceFinanze= Integer.parseInt(config.getProperty("ods.col.codice.finanze"));
			colNomeComune = Integer.parseInt(config.getProperty("ods.col.nome.comune"));
			colNomeProvincia = Integer.parseInt(config.getProperty("ods.col.nome.provincia"));
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
	}
	
	public void confronta()
	{

/*
 * Cicla sulle righe del primo foglio. L'unico modo per non andare in loop
 * infinito sulle righe è vedere se la prima cella di una riga è vuota, almeno
 * in questo caso. Altrimenti si ferma dopo 1MB di righe.
 */
		Table table = input.getSheetByIndex(0);
		Iterator<Row> rows = table.getRowIterator();
		outDiversi.println("istat	abi	finanze	comune	provincia	");
		outMancanti.println("istat	finanze	comune istat	comune abi");
		while(rows.hasNext())
		{
			Row row = rows.next();
			if(row.getCellByIndex(0).getStringValue().equals("")) break;
			String istatIstat = row.getCellByIndex(colCodiceComune).getStringValue();
			String finanzeIstat = row.getCellByIndex(colCodiceFinanze).getStringValue();
			String comuneIstat = row.getCellByIndex(colNomeComune).getStringValue();
			String provinciaIstat = row.getCellByIndex(colNomeProvincia).getStringValue();
			log.debug(istatIstat + "	" + comuneIstat);
			try
			{
				qComune.setString(1, comuneIstat);
				ResultSet rs = qComune.executeQuery();
				if(rs.next())
				{
					do
					{
						String istatAbi = rs.getString(1);
						if(!istatAbi.equals(istatIstat))
						{
							outDiversi.println(istatIstat + "	" + rs.getString(1) + "	" + finanzeIstat + "	" + rs.getString(2) + "	" + provinciaIstat);
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
							outMancanti.println(istatIstat + "	" + finanzeIstat + "	" + comuneIstat + "	" + comuneAbi);
						}
						while(rs2.next());
					}
					else
					{
						outMancanti.println(istatIstat + "	" + finanzeIstat + "	" + comuneIstat + "	" + null);
					}
				}
			}
			catch(SQLException e)
			{
				e.printStackTrace();
			}
		}
	}

	public static void main(String[] args)
	{
		Confronto c = new Confronto();
		c.confronta();
		c.free();
	}
}
