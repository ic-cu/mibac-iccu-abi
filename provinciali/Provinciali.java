package provinciali;

import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;

import sql.DB;

public class Provinciali
{
	public Provinciali()
	{
		Vector<String> isilVector = new Vector<String>();
		BufferedReader isilFile = null;
		PrintWriter dati = null;
		String isil = "";
		DB db = new DB(DB.urlGauss, "abi", "");
		PreparedStatement bibHasAnnoFond = db.prepare("select data_fondazione, isil_provincia, isil_numero" + " from biblioteca"
				+ " where concat('IT-', isil_provincia, lpad(isil_numero, 4, 0)) = ?");
		PreparedStatement bibHasVolumi = db.prepare("select data_fondazione, " + " quantita, isil_provincia, isil_numero"
				+ " from patrimonio right outer join biblioteca" + " on biblioteca.id_biblioteca = patrimonio.id_biblioteca"
				+ " where patrimonio.id_patrimonio_specializzazione = 20000" + " and concat('IT-', isil_provincia, lpad(isil_numero, 4, 0)) = ?");
		PreparedStatement bibHasSBN = db.prepare("select isil_provincia, isil_numero"
				+ " from biblioteca, partecipa_cataloghi_collettivi_materiale"
				+ " where biblioteca.id_biblioteca = partecipa_cataloghi_collettivi_materiale.id_biblioteca" + " and id_cataloghi_collettivi = 146"
				+ " and concat('IT-', isil_provincia, lpad(isil_numero, 4, 0)) = ?");
		PreparedStatement bibHasReti = db.prepare("select isil_provincia, isil_numero" + " from biblioteca, biblioteca_has_sistemi_biblioteche"
				+ " where biblioteca.id_biblioteca = biblioteca_has_sistemi_biblioteche.id_biblioteca"
				+ " and concat('IT-', isil_provincia, lpad(isil_numero, 4, 0)) = ?");
		try
		{
			isilFile = new BufferedReader(new FileReader("provinciali/isil.csv"));
			dati = new PrintWriter("provinciali/dati.csv");
		}
		catch(FileNotFoundException e)
		{

		}
		try
		{
			int i = 0;

/*
 * Scorre l'elenco degli ISIL. Per ciascuno fa alcune query
 */
			System.out.println("prog;ISIL;SBN;RETI;VOLUMI;FONDAZIONE");
			dati.println("prog;ISIL;SBN;RETI;VOLUMI;FONDAZIONE");
			while(isilFile.ready())
			{
				isil = isilFile.readLine();

/*
 * Partecipa o meno a SBN
 */

				bibHasSBN.setString(1, isil);
				ResultSet rs = bibHasSBN.executeQuery();
				System.out.print(++i + ";" + isil + ";");
				dati.print(i + ";" + isil + ";");
				if(rs.next())
				{
					System.out.print("SI");
					dati.print("SI");
				}
				else
				{
					System.out.print("NO");
					dati.print("NO");
				}

/*
 * Partecipa a qualche sistema
 */

				bibHasReti.setString(1, isil);
				rs = bibHasReti.executeQuery();
				System.out.print(";");
				dati.print(";");
				if(rs.next())
				{
					System.out.print("SI");
					dati.print("SI");
				}
				else
				{
					System.out.print("NO");
					dati.print("NO");
				}

/*
 * Eventuali volumi e opuscoli, oppure 0
 */

				bibHasVolumi.setString(1, isil);
				rs = bibHasVolumi.executeQuery();
				System.out.print(";");
				dati.print(";");
				if(rs.next())
				{
					String q = rs.getString("quantita");
					if(q == null || q.equals("null"))
					{
						System.out.print("0");
						dati.print("0");
					}
					else
					{
						System.out.print(q);
						dati.print(q);
					}
				}
				else
				{
					System.out.print("0");
					dati.print("0");
				}

/*
 * Anno fondazione
 */

				bibHasAnnoFond.setString(1, isil);
				rs = bibHasAnnoFond.executeQuery();
				System.out.print(";");
				dati.print(";");
				rs.next();
				System.out.print(rs.getShort("data_fondazione"));
				dati.print(rs.getShort("data_fondazione"));
				System.out.println();
				dati.println();
			}
			isilFile.close();
			dati.close();
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

	public static void main(String args[])
	{
		Provinciali p = new Provinciali();
	}
}
