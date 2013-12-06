package sbn;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DecimalFormat;
import java.util.Collection;
import java.util.Enumeration;
import java.util.Properties;

import sql.DB;

/*
 * Classe per confrontare biblioteche SBN sul sito ICCU e sull'ABI, ai fini di
 * un allineamento. Dal punto di vista del sito ICCU fanno fede le pagine
 * "Poli e biblioteche SBN", costantemente aggiornate. Dal punto di vista ABI
 * conta la partecipazione al catalogo collettivo SBN.
 */
public class ConfrontoIndiceAbi
{

	public ConfrontoIndiceAbi()
	{
		FileReader fr = null;
		config = new Properties();
		sbnIsil = new Properties();
		/*
		 * Vengono creati un certo numero di file per salvare diverse informazioni.
		 * In particolare, l'elenco delle biblioteche SBN in ABI che non risultano
		 * SBN sul sito ICCU, e quelle che secondo il sito ICCU sono SBN ma non
		 * secondo l'ABI.
		 */
		try
		{
			fr = new FileReader(new File("polisbn/config.prop"));
			config.load(fr);
			fr.close();
			fr = new FileReader(new File("sbn/sbn-isil.properties"));
			sbnIsil.load(fr);
			fr.close();
			logPW = new PrintWriter(new File(config.getProperty("file-log")));
			statPW = new PrintWriter(new File(config.getProperty("file-statistiche")));
			errorPW = new PrintWriter(new File(config.getProperty("file-errori")));
			nosbnPW = new PrintWriter(new File(config.getProperty("file-nosbn")));
			dupPW = new PrintWriter(new File(config.getProperty("file-duplicate")));
			oldPW = new PrintWriter(new File(config.getProperty("file-obsolete")));
			tuttePW = new PrintWriter(new File(config.getProperty("file-tutte")));
		}
		catch(FileNotFoundException e)
		{
			e.printStackTrace();
		}
		catch(IOException e)
		{
			e.printStackTrace();
		}
	}

	private Properties config;
	private Properties sbnIsil;
	private PrintWriter logPW = null;
	private PrintWriter statPW = null;
	private PrintWriter errorPW = null;
	private PrintWriter nosbnPW = null;
	private PrintWriter dupPW = null;
	private PrintWriter oldPW = null;
	private PrintWriter tuttePW = null;
	private DB db;

	public void setLog(String logFileName)
	{
		try
		{
			logPW = new PrintWriter(new File(logFileName));
		}
		catch(FileNotFoundException e)
		{
			System.err.println("File di log " + logFileName + " non trovato");
		}
	}

	// È sempre una buona pratica chiudere i file alla fine.

	public void closeLog()
	{
		if(logPW != null)
		{
			logPW.close();
		}
		if(statPW != null)
		{
			statPW.close();
		}
		if(errorPW != null)
		{
			errorPW.close();
		}
		if(nosbnPW != null)
		{
			nosbnPW.close();
		}
		if(dupPW != null)
		{
			dupPW.close();
		}
		if(oldPW != null)
		{
			oldPW.close();
		}
	}

	// logger su out e su un file di log
	public void log(String msg)
	{
		System.out.println(msg);
		if(logPW != null)
		{
			logPW.println(msg);
		}
	}

	// logger su out, su file di log e su un altro file
	public void log(String msg, PrintWriter pw)
	{
		log(msg);
		if(pw != null)
		{
			pw.println(msg);
		}
	}

	/*
	 * Itera sui poli e cerca in ABI ogni biblioteca trovata, vedendo se partecipa
	 * al catalogo collettivo SBN (ma prima ancora, se esiste in ABI).
	 */

	public void cercaInAbi() // throws BibliotecaDuplicataException
	{
		ResultSet rs = null;
		PreparedStatement existsBib = db.prepare("select" + " id_biblioteca,"
				+ " denominazione_ufficiale denominazione" + " from biblioteca"
				+ " where not id_stato_biblioteca_workflow=4"
				+ " and concat('IT-', isil_provincia, lpad(isil_numero, 4, '0')) = ?");
		PreparedStatement bibHasSBN = db.prepare("select count(*)"
				+ " from partecipa_cataloghi_collettivi_materiale"
				+ " where id_cataloghi_collettivi = 146" + " and id_biblioteca = ?");
		int ii = 0;
		int jj = 0;
		Enumeration<Object> i = sbnIsil.keys();
		while(i.hasMoreElements())
		{
			String sbn = (String) i.nextElement();
			String isil = sbnIsil.getProperty(sbn);
			if(isil.length() != 9 || sbn.length() != 5
					|| isil.substring(0, 2).equals("EX"))
			{
				log("* codice mal formato: [" + isil + " - " + sbn + "]", errorPW);
			}
			else
			{
				try
				{
					// vediamo prima se c'è la biblioteca
					existsBib.setString(1, isil);
					rs = existsBib.executeQuery();
					String msg = isil + ";" + sbn;
					if(rs.last())
					{
						// se arriva qui, esiste la biblioteca, quindi si
						// può vedere se partecipa a SBN.
						// mette da parte un report con la denominazione ABI
						String msg2 = isil + ";" + sbn + ";"
								+ rs.getString("denominazione");
						log(msg2, tuttePW);
						++ii;
						int idBib = rs.getInt(1);
						bibHasSBN.setInt(1, idBib);
						rs = bibHasSBN.executeQuery();
						rs.last();
						// se il conteggio è 0, la biblioteca non partecipa
						// a SBN secondo l'ABI e viene segnalata
						if(rs.getInt(1) == 0)
						{
							log(msg, nosbnPW);
							jj++;
						}
					}
					else
					{
						// se arriva qui, la biblioteca non esiste in ABI,
						// per cui segnala la cosa
						log("* mancante in ABI:" + msg, errorPW);
					}
				}
				catch(SQLException e)
				{
					e.printStackTrace();
				}
			}
		}
		log("Su " + ii
				+ " biblioteche in ABI presenti in Indice con codici validi, " + jj
				+ " non partecipano al catalogo collettivo SBN", statPW);
	}

	/*
	 * Cerchiamo sul sito ICCU le biblioteche ABI che partecipano al catalogo
	 * collettivo SBN. Infatti alcune di queste potrebbero essere uscite da SBN ma
	 * in ABI non è stata rimossa la loro partecipazione al catalogo.
	 */
	public void cercaInIndice()
	{
		ResultSet rs = null;
		// elenchiamo le biblioteche ABI che partecipano a SBN
		rs = db
				.select("select isil_provincia, isil_numero,"
						+ " valore sbn, denominazione_ufficiale denominazione"
						+ " from biblioteca b,"
						+ " partecipa_cataloghi_collettivi_materiale c," + " codici"
						+ " where not b.id_stato_biblioteca_workflow=4"
						+ " and c.id_cataloghi_collettivi= 146"
						+ " and c.id_biblioteca = b.id_biblioteca"
						+ " and codici.id_biblioteca = b.id_biblioteca"
						+ " and codici.id_codici = 5"
						+ " order by isil_provincia, isil_numero");
		// popoliamo una mappa delle biblioteche dal sito ICCU
		// per cercare più facilmente
		// ora si può ciclare sul resultset e cercare le biblioteche sul sito

		Collection<Object> isil = sbnIsil.values();
		String isilPR, isilNR;
		int ii = 0;
		int jj = 0;
		try
		{
			DecimalFormat df = new DecimalFormat("0000");
			while(rs.next())
			{
				ii++;
				isilPR = rs.getString("isil_provincia");
				isilNR = df.format(rs.getInt("isil_numero"));
				if(! isil.contains("IT-" + isilPR + isilNR))
				{
					jj++;
					log(isilPR + isilNR + ";" + rs.getString("sbn") + ";"
							+ rs.getString("denominazione"), oldPW);
				}
			}
			log("Su " + ii
					+ " biblioteche ABI partecipanti al catalogo collettivo SBN, " + jj
					+ " non risultano in Indice", statPW);
		}
		catch(SQLException e)
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	/**
	 * L'argomento è la directory contenente le regioni.
	 */
	public static void main(String[] args)
	{
		ConfrontoIndiceAbi c = new ConfrontoIndiceAbi();
		c.db = new DB(DB.urlTest, args[0], args[1]);
		//c.cercaInAbi();
		c.cercaInIndice();
		c.closeLog();
		c.db.free();
	}
}
