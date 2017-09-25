package xml;

import java.io.IOException;

import util.log.Log;
import xml.xsd.v16.Biblioteche;

/**  Description of the Class */

public class TestXML
{	
	public static void main(String[] args) throws IOException
	{
		Log.init("xml/log.prop");
//		System.err.println(args[0]);
		ControlliXML t = new ControlliXML("xml/controlli.prop");
		Biblioteche b = t.carica(args[0]);
//		t.lista(b);
		t.isil(b);
		t.fonteAICE(b);
		t.statoCat(b);
		t.valori(args[0]);
	}
}

