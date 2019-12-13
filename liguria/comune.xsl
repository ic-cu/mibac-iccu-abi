<?xml version="1.0" ?>
<xsl:stylesheet version="1.0"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="xml" indent="yes" />

	<xsl:template match="//scheda_BIBLIO/RECAPITI/COMUNE">
		<xsl:choose>
			<xsl:when test=". = 'AIROLE'">
				<comune>008001</comune>
				<provincia>008</provincia>
			</xsl:when>
			<xsl:when test=". = 'APRICALE'">
				<comune>008002</comune>
				<provincia>008</provincia>
			</xsl:when>
			<xsl:when test=". = 'AQUILA D&amp;apos;ARROSCIA'">
				<comune>008003</comune>
				<provincia>008</provincia>
			</xsl:when>
			<xsl:when test=". = 'ARMO'">
				<comune>008004</comune>
				<provincia>008</provincia>
			</xsl:when>
			<xsl:when test=". = 'AURIGO'">
				<comune>008005</comune>
				<provincia>008</provincia>
			</xsl:when>
			<xsl:when test=". = 'BADALUCCO'">
				<comune>008006</comune>
				<provincia>008</provincia>
			</xsl:when>
			<xsl:when test=". = 'BAJARDO'">
				<comune>008007</comune>
				<provincia>008</provincia>
			</xsl:when>
			<xsl:when test=". = 'BAIARDO'">
				<comune>008007</comune>
				<provincia>008</provincia>
			</xsl:when>
			<xsl:when test=". = 'BORDIGHERA'">
				<comune>008008</comune>
				<provincia>008</provincia>
			</xsl:when>
			<xsl:when test=". = 'BORGHETTO D&amp;apos;ARROSCIA'">
				<comune>008009</comune>
				<provincia>008</provincia>
			</xsl:when>
			<xsl:when test=". = 'BORGOMARO'">
				<comune>008010</comune>
				<provincia>008</provincia>
			</xsl:when>
			<xsl:when test=". = 'CAMPOROSSO'">
				<comune>008011</comune>
				<provincia>008</provincia>
			</xsl:when>
			<xsl:when test=". = 'CARAVONICA'">
				<comune>008012</comune>
				<provincia>008</provincia>
			</xsl:when>
			<xsl:when test=". = 'CARPASIO'">
				<comune>008013</comune>
				<provincia>008</provincia>
			</xsl:when>
			<xsl:when test=". = 'CASTELLARO'">
				<comune>008014</comune>
				<provincia>008</provincia>
			</xsl:when>
			<xsl:when test=". = 'CASTEL VITTORIO'">
				<comune>008015</comune>
				<provincia>008</provincia>
			</xsl:when>
			<xsl:when test=". = 'CERIANA'">
				<comune>008016</comune>
				<provincia>008</provincia>
			</xsl:when>
			<xsl:when test=". = 'CERVO'">
				<comune>008017</comune>
				<provincia>008</provincia>
			</xsl:when>
			<xsl:when test=". = 'CESIO'">
				<comune>008018</comune>
				<provincia>008</provincia>
			</xsl:when>
			<xsl:when test=". = 'CHIUSANICO'">
				<comune>008019</comune>
				<provincia>008</provincia>
			</xsl:when>
			<xsl:when test=". = 'CHIUSAVECCHIA'">
				<comune>008020</comune>
				<provincia>008</provincia>
			</xsl:when>
			<xsl:when test=". = 'CIPRESSA'">
				<comune>008021</comune>
				<provincia>008</provincia>
			</xsl:when>
			<xsl:when test=". = 'CIVEZZA'">
				<comune>008022</comune>
				<provincia>008</provincia>
			</xsl:when>
			<xsl:when test=". = 'COSIO D&amp;apos;ARROSCIA'">
				<comune>008023</comune>
				<provincia>008</provincia>
			</xsl:when>
			<xsl:when test=". = 'COSTARAINERA'">
				<comune>008024</comune>
				<provincia>008</provincia>
			</xsl:when>
			<xsl:when test=". = 'DIANO ARENTINO'">
				<comune>008025</comune>
				<provincia>008</provincia>
			</xsl:when>
			<xsl:when test=". = 'DIANO CASTELLO'">
				<comune>008026</comune>
				<provincia>008</provincia>
			</xsl:when>
			<xsl:when test=". = 'DIANO MARINA'">
				<comune>008027</comune>
				<provincia>008</provincia>
			</xsl:when>
			<xsl:when test=". = 'DIANO SAN PIETRO'">
				<comune>008028</comune>
				<provincia>008</provincia>
			</xsl:when>
			<xsl:when test=". = 'DOLCEACQUA'">
				<comune>008029</comune>
				<provincia>008</provincia>
			</xsl:when>
			<xsl:when test=". = 'DOLCEDO'">
				<comune>008030</comune>
				<provincia>008</provincia>
			</xsl:when>
			<xsl:when test=". = 'IMPERIA'">
				<comune>008031</comune>
				<provincia>008</provincia>
			</xsl:when>
			<xsl:when test=". = 'ISOLABONA'">
				<comune>008032</comune>
				<provincia>008</provincia>
			</xsl:when>
			<xsl:when test=". = 'LUCINASCO'">
				<comune>008033</comune>
				<provincia>008</provincia>
			</xsl:when>
			<xsl:when test=". = 'MENDATICA'">
				<comune>008034</comune>
				<provincia>008</provincia>
			</xsl:when>
			<xsl:when test=". = 'MOLINI DI TRIORA'">
				<comune>008035</comune>
				<provincia>008</provincia>
			</xsl:when>
			<xsl:when test=". = 'MONTALTO LIGURE'">
				<comune>008036</comune>
				<provincia>008</provincia>
			</xsl:when>
			<xsl:when test=". = 'MONTEGROSSO PIAN LATTE'">
				<comune>008037</comune>
				<provincia>008</provincia>
			</xsl:when>
			<xsl:when test=". = 'OLIVETTA SAN MICHELE'">
				<comune>008038</comune>
				<provincia>008</provincia>
			</xsl:when>
			<xsl:when test=". = 'OSPEDALETTI'">
				<comune>008039</comune>
				<provincia>008</provincia>
			</xsl:when>
			<xsl:when test=". = 'PERINALDO'">
				<comune>008040</comune>
				<provincia>008</provincia>
			</xsl:when>
			<xsl:when test=". = 'PIETRABRUNA'">
				<comune>008041</comune>
				<provincia>008</provincia>
			</xsl:when>
			<xsl:when test=". = 'PIEVE DI TECO'">
				<comune>008042</comune>
				<provincia>008</provincia>
			</xsl:when>
			<xsl:when test=". = 'PIGNA'">
				<comune>008043</comune>
				<provincia>008</provincia>
			</xsl:when>
			<xsl:when test=". = 'POMPEIANA'">
				<comune>008044</comune>
				<provincia>008</provincia>
			</xsl:when>
			<xsl:when test=". = 'PONTEDASSIO'">
				<comune>008045</comune>
				<provincia>008</provincia>
			</xsl:when>
			<xsl:when test=". = 'PORNASSIO'">
				<comune>008046</comune>
				<provincia>008</provincia>
			</xsl:when>
			<xsl:when test=". = 'PRELÀ'">
				<comune>008047</comune>
				<provincia>008</provincia>
			</xsl:when>
			<xsl:when test=". = 'RANZO'">
				<comune>008048</comune>
				<provincia>008</provincia>
			</xsl:when>
			<xsl:when test=". = 'REZZO'">
				<comune>008049</comune>
				<provincia>008</provincia>
			</xsl:when>
			<xsl:when test=". = 'RIVA LIGURE'">
				<comune>008050</comune>
				<provincia>008</provincia>
			</xsl:when>
			<xsl:when test=". = 'ROCCHETTA NERVINA'">
				<comune>008051</comune>
				<provincia>008</provincia>
			</xsl:when>
			<xsl:when test=". = 'SAN BARTOLOMEO AL MARE'">
				<comune>008052</comune>
				<provincia>008</provincia>
			</xsl:when>
			<xsl:when test=". = 'SAN BIAGIO DELLA CIMA'">
				<comune>008053</comune>
				<provincia>008</provincia>
			</xsl:when>
			<xsl:when test=". = 'SAN LORENZO AL MARE'">
				<comune>008054</comune>
				<provincia>008</provincia>
			</xsl:when>
			<xsl:when test=". = 'SANREMO'">
				<comune>008055</comune>
				<provincia>008</provincia>
			</xsl:when>
			<xsl:when test=". = 'SAN REMO'">
				<comune>008055</comune>
				<provincia>008</provincia>
			</xsl:when>
			<xsl:when test=". = 'SANTO STEFANO AL MARE'">
				<comune>008056</comune>
				<provincia>008</provincia>
			</xsl:when>
			<xsl:when test=". = 'SEBORGA'">
				<comune>008057</comune>
				<provincia>008</provincia>
			</xsl:when>
			<xsl:when test=". = 'SOLDANO'">
				<comune>008058</comune>
				<provincia>008</provincia>
			</xsl:when>
			<xsl:when test=". = 'TAGGIA'">
				<comune>008059</comune>
				<provincia>008</provincia>
			</xsl:when>
			<xsl:when test=". = 'TERZORIO'">
				<comune>008060</comune>
				<provincia>008</provincia>
			</xsl:when>
			<xsl:when test=". = 'TRIORA'">
				<comune>008061</comune>
				<provincia>008</provincia>
			</xsl:when>
			<xsl:when test=". = 'VALLEBONA'">
				<comune>008062</comune>
				<provincia>008</provincia>
			</xsl:when>
			<xsl:when test=". = 'VALLECROSIA'">
				<comune>008063</comune>
				<provincia>008</provincia>
			</xsl:when>
			<xsl:when test=". = 'VASIA'">
				<comune>008064</comune>
				<provincia>008</provincia>
			</xsl:when>
			<xsl:when test=". = 'VENTIMIGLIA'">
				<comune>008065</comune>
				<provincia>008</provincia>
			</xsl:when>
			<xsl:when test=". = 'VESSALICO'">
				<comune>008066</comune>
				<provincia>008</provincia>
			</xsl:when>
			<xsl:when test=". = 'VILLA FARALDI'">
				<comune>008067</comune>
				<provincia>008</provincia>
			</xsl:when>
			<xsl:when test=". = 'ALASSIO'">
				<comune>009001</comune>
				<provincia>009</provincia>
			</xsl:when>
			<xsl:when test=". = 'ALBENGA'">
				<comune>009002</comune>
				<provincia>009</provincia>
			</xsl:when>
			<xsl:when test=". = 'ALBISSOLA MARINA'">
				<comune>009003</comune>
				<provincia>009</provincia>
			</xsl:when>
			<xsl:when test=". = 'ALBISOLA SUPERIORE'">
				<comune>009004</comune>
				<provincia>009</provincia>
			</xsl:when>
			<xsl:when test=". = 'ALTARE'">
				<comune>009005</comune>
				<provincia>009</provincia>
			</xsl:when>
			<xsl:when test=". = 'ANDORA'">
				<comune>009006</comune>
				<provincia>009</provincia>
			</xsl:when>
			<xsl:when test=". = 'ARNASCO'">
				<comune>009007</comune>
				<provincia>009</provincia>
			</xsl:when>
			<xsl:when test=". = 'BALESTRINO'">
				<comune>009008</comune>
				<provincia>009</provincia>
			</xsl:when>
			<xsl:when test=". = 'BARDINETO'">
				<comune>009009</comune>
				<provincia>009</provincia>
			</xsl:when>
			<xsl:when test=". = 'BERGEGGI'">
				<comune>009010</comune>
				<provincia>009</provincia>
			</xsl:when>
			<xsl:when test=". = 'BOISSANO'">
				<comune>009011</comune>
				<provincia>009</provincia>
			</xsl:when>
			<xsl:when test=". = 'BORGHETTO SANTO SPIRITO'">
				<comune>009012</comune>
				<provincia>009</provincia>
			</xsl:when>
			<xsl:when test=". = 'BORGIO VEREZZI'">
				<comune>009013</comune>
				<provincia>009</provincia>
			</xsl:when>
			<xsl:when test=". = 'BORMIDA'">
				<comune>009014</comune>
				<provincia>009</provincia>
			</xsl:when>
			<xsl:when test=". = 'CAIRO MONTENOTTE'">
				<comune>009015</comune>
				<provincia>009</provincia>
			</xsl:when>
			<xsl:when test=". = 'CALICE LIGURE'">
				<comune>009016</comune>
				<provincia>009</provincia>
			</xsl:when>
			<xsl:when test=". = 'CALIZZANO'">
				<comune>009017</comune>
				<provincia>009</provincia>
			</xsl:when>
			<xsl:when test=". = 'CARCARE'">
				<comune>009018</comune>
				<provincia>009</provincia>
			</xsl:when>
			<xsl:when test=". = 'CASANOVA LERRONE'">
				<comune>009019</comune>
				<provincia>009</provincia>
			</xsl:when>
			<xsl:when test=". = 'CASTELBIANCO'">
				<comune>009020</comune>
				<provincia>009</provincia>
			</xsl:when>
			<xsl:when test=". = 'CASTELVECCHIO DI ROCCA BARBENA'">
				<comune>009021</comune>
				<provincia>009</provincia>
			</xsl:when>
			<xsl:when test=". = 'CELLE LIGURE'">
				<comune>009022</comune>
				<provincia>009</provincia>
			</xsl:when>
			<xsl:when test=". = 'CENGIO'">
				<comune>009023</comune>
				<provincia>009</provincia>
			</xsl:when>
			<xsl:when test=". = 'CERIALE'">
				<comune>009024</comune>
				<provincia>009</provincia>
			</xsl:when>
			<xsl:when test=". = 'CISANO SUL NEVA'">
				<comune>009025</comune>
				<provincia>009</provincia>
			</xsl:when>
			<xsl:when test=". = 'COSSERIA'">
				<comune>009026</comune>
				<provincia>009</provincia>
			</xsl:when>
			<xsl:when test=". = 'DEGO'">
				<comune>009027</comune>
				<provincia>009</provincia>
			</xsl:when>
			<xsl:when test=". = 'ERLI'">
				<comune>009028</comune>
				<provincia>009</provincia>
			</xsl:when>
			<xsl:when test=". = 'FINALE LIGURE'">
				<comune>009029</comune>
				<provincia>009</provincia>
			</xsl:when>
			<xsl:when test=". = 'GARLENDA'">
				<comune>009030</comune>
				<provincia>009</provincia>
			</xsl:when>
			<xsl:when test=". = 'GIUSTENICE'">
				<comune>009031</comune>
				<provincia>009</provincia>
			</xsl:when>
			<xsl:when test=". = 'GIUSVALLA'">
				<comune>009032</comune>
				<provincia>009</provincia>
			</xsl:when>
			<xsl:when test=". = 'LAIGUEGLIA'">
				<comune>009033</comune>
				<provincia>009</provincia>
			</xsl:when>
			<xsl:when test=". = 'LOANO'">
				<comune>009034</comune>
				<provincia>009</provincia>
			</xsl:when>
			<xsl:when test=". = 'MAGLIOLO'">
				<comune>009035</comune>
				<provincia>009</provincia>
			</xsl:when>
			<xsl:when test=". = 'MALLARE'">
				<comune>009036</comune>
				<provincia>009</provincia>
			</xsl:when>
			<xsl:when test=". = 'MASSIMINO'">
				<comune>009037</comune>
				<provincia>009</provincia>
			</xsl:when>
			<xsl:when test=". = 'MILLESIMO'">
				<comune>009038</comune>
				<provincia>009</provincia>
			</xsl:when>
			<xsl:when test=". = 'MIOGLIA'">
				<comune>009039</comune>
				<provincia>009</provincia>
			</xsl:when>
			<xsl:when test=". = 'MURIALDO'">
				<comune>009040</comune>
				<provincia>009</provincia>
			</xsl:when>
			<xsl:when test=". = 'NASINO'">
				<comune>009041</comune>
				<provincia>009</provincia>
			</xsl:when>
			<xsl:when test=". = 'NOLI'">
				<comune>009042</comune>
				<provincia>009</provincia>
			</xsl:when>
			<xsl:when test=". = 'ONZO'">
				<comune>009043</comune>
				<provincia>009</provincia>
			</xsl:when>
			<xsl:when test=". = 'ORCO FEGLINO'">
				<comune>009044</comune>
				<provincia>009</provincia>
			</xsl:when>
			<xsl:when test=". = 'ORTOVERO'">
				<comune>009045</comune>
				<provincia>009</provincia>
			</xsl:when>
			<xsl:when test=". = 'OSIGLIA'">
				<comune>009046</comune>
				<provincia>009</provincia>
			</xsl:when>
			<xsl:when test=". = 'PALLARE'">
				<comune>009047</comune>
				<provincia>009</provincia>
			</xsl:when>
			<xsl:when test=". = 'PIANA CRIXIA'">
				<comune>009048</comune>
				<provincia>009</provincia>
			</xsl:when>
			<xsl:when test=". = 'PIETRA LIGURE'">
				<comune>009049</comune>
				<provincia>009</provincia>
			</xsl:when>
			<xsl:when test=". = 'PLODIO'">
				<comune>009050</comune>
				<provincia>009</provincia>
			</xsl:when>
			<xsl:when test=". = 'PONTINVREA'">
				<comune>009051</comune>
				<provincia>009</provincia>
			</xsl:when>
			<xsl:when test=". = 'QUILIANO'">
				<comune>009052</comune>
				<provincia>009</provincia>
			</xsl:when>
			<xsl:when test=". = 'RIALTO'">
				<comune>009053</comune>
				<provincia>009</provincia>
			</xsl:when>
			<xsl:when test=". = 'ROCCAVIGNALE'">
				<comune>009054</comune>
				<provincia>009</provincia>
			</xsl:when>
			<xsl:when test=". = 'SASSELLO'">
				<comune>009055</comune>
				<provincia>009</provincia>
			</xsl:when>
			<xsl:when test=". = 'SAVONA'">
				<comune>009056</comune>
				<provincia>009</provincia>
			</xsl:when>
			<xsl:when test=". = 'SPOTORNO'">
				<comune>009057</comune>
				<provincia>009</provincia>
			</xsl:when>
			<xsl:when test=". = 'STELLA'">
				<comune>009058</comune>
				<provincia>009</provincia>
			</xsl:when>
			<xsl:when test=". = 'STELLANELLO'">
				<comune>009059</comune>
				<provincia>009</provincia>
			</xsl:when>
			<xsl:when test=". = 'TESTICO'">
				<comune>009060</comune>
				<provincia>009</provincia>
			</xsl:when>
			<xsl:when test=". = 'TOIRANO'">
				<comune>009061</comune>
				<provincia>009</provincia>
			</xsl:when>
			<xsl:when test=". = 'TOVO SAN GIACOMO'">
				<comune>009062</comune>
				<provincia>009</provincia>
			</xsl:when>
			<xsl:when test=". = 'URBE'">
				<comune>009063</comune>
				<provincia>009</provincia>
			</xsl:when>
			<xsl:when test=". = 'VADO LIGURE'">
				<comune>009064</comune>
				<provincia>009</provincia>
			</xsl:when>
			<xsl:when test=". = 'VARAZZE'">
				<comune>009065</comune>
				<provincia>009</provincia>
			</xsl:when>
			<xsl:when test=". = 'VENDONE'">
				<comune>009066</comune>
				<provincia>009</provincia>
			</xsl:when>
			<xsl:when test=". = 'VEZZI PORTIO'">
				<comune>009067</comune>
				<provincia>009</provincia>
			</xsl:when>
			<xsl:when test="starts-with(., 'VILLANOVA D')">
				<comune>009068</comune>
				<provincia>009</provincia>
			</xsl:when>
			<xsl:when test=". = 'ZUCCARELLO'">
				<comune>009069</comune>
				<provincia>009</provincia>
			</xsl:when>
			<xsl:when test=". = 'ARENZANO'">
				<comune>010001</comune>
				<provincia>010</provincia>
			</xsl:when>
			<xsl:when test=". = 'AVEGNO'">
				<comune>010002</comune>
				<provincia>010</provincia>
			</xsl:when>
			<xsl:when test=". = 'BARGAGLI'">
				<comune>010003</comune>
				<provincia>010</provincia>
			</xsl:when>
			<xsl:when test=". = 'BOGLIASCO'">
				<comune>010004</comune>
				<provincia>010</provincia>
			</xsl:when>
			<xsl:when test=". = 'BORZONASCA'">
				<comune>010005</comune>
				<provincia>010</provincia>
			</xsl:when>
			<xsl:when test=". = 'BUSALLA'">
				<comune>010006</comune>
				<provincia>010</provincia>
			</xsl:when>
			<xsl:when test=". = 'CAMOGLI'">
				<comune>010007</comune>
				<provincia>010</provincia>
			</xsl:when>
			<xsl:when test=". = 'CAMPO LIGURE'">
				<comune>010008</comune>
				<provincia>010</provincia>
			</xsl:when>
			<xsl:when test=". = 'CAMPOMORONE'">
				<comune>010009</comune>
				<provincia>010</provincia>
			</xsl:when>
			<xsl:when test=". = 'CARASCO'">
				<comune>010010</comune>
				<provincia>010</provincia>
			</xsl:when>
			<xsl:when test=". = 'CASARZA LIGURE'">
				<comune>010011</comune>
				<provincia>010</provincia>
			</xsl:when>
			<xsl:when test=". = 'CASELLA'">
				<comune>010012</comune>
				<provincia>010</provincia>
			</xsl:when>
			<xsl:when test=". = 'CASTIGLIONE CHIAVARESE'">
				<comune>010013</comune>
				<provincia>010</provincia>
			</xsl:when>
			<xsl:when test=". = 'CERANESI'">
				<comune>010014</comune>
				<provincia>010</provincia>
			</xsl:when>
			<xsl:when test=". = 'CHIAVARI'">
				<comune>010015</comune>
				<provincia>010</provincia>
			</xsl:when>
			<xsl:when test=". = 'CICAGNA'">
				<comune>010016</comune>
				<provincia>010</provincia>
			</xsl:when>
			<xsl:when test=". = 'COGOLETO'">
				<comune>010017</comune>
				<provincia>010</provincia>
			</xsl:when>
			<xsl:when test=". = 'COGORNO'">
				<comune>010018</comune>
				<provincia>010</provincia>
			</xsl:when>
			<xsl:when test=". = 'COREGLIA LIGURE'">
				<comune>010019</comune>
				<provincia>010</provincia>
			</xsl:when>
			<xsl:when test=". = 'CROCEFIESCHI'">
				<comune>010020</comune>
				<provincia>010</provincia>
			</xsl:when>
			<xsl:when test=". = 'DAVAGNA'">
				<comune>010021</comune>
				<provincia>010</provincia>
			</xsl:when>
			<xsl:when test=". = 'FASCIA'">
				<comune>010022</comune>
				<provincia>010</provincia>
			</xsl:when>
			<xsl:when test=". = 'FAVALE DI MALVARO'">
				<comune>010023</comune>
				<provincia>010</provincia>
			</xsl:when>
			<xsl:when test=". = 'FONTANIGORDA'">
				<comune>010024</comune>
				<provincia>010</provincia>
			</xsl:when>
			<xsl:when test=". = 'GENOVA'">
				<comune>010025</comune>
				<provincia>010</provincia>
			</xsl:when>
			<xsl:when test=". = 'GORRETO'">
				<comune>010026</comune>
				<provincia>010</provincia>
			</xsl:when>
			<xsl:when test=". = 'ISOLA DEL CANTONE'">
				<comune>010027</comune>
				<provincia>010</provincia>
			</xsl:when>
			<xsl:when test=". = 'LAVAGNA'">
				<comune>010028</comune>
				<provincia>010</provincia>
			</xsl:when>
			<xsl:when test=". = 'LEIVI'">
				<comune>010029</comune>
				<provincia>010</provincia>
			</xsl:when>
			<xsl:when test=". = 'LORSICA'">
				<comune>010030</comune>
				<provincia>010</provincia>
			</xsl:when>
			<xsl:when test=". = 'LUMARZO'">
				<comune>010031</comune>
				<provincia>010</provincia>
			</xsl:when>
			<xsl:when test=". = 'MASONE'">
				<comune>010032</comune>
				<provincia>010</provincia>
			</xsl:when>
			<xsl:when test=". = 'MELE'">
				<comune>010033</comune>
				<provincia>010</provincia>
			</xsl:when>
			<xsl:when test=". = 'MEZZANEGO'">
				<comune>010034</comune>
				<provincia>010</provincia>
			</xsl:when>
			<xsl:when test=". = 'MIGNANEGO'">
				<comune>010035</comune>
				<provincia>010</provincia>
			</xsl:when>
			<xsl:when test=". = 'MOCONESI'">
				<comune>010036</comune>
				<provincia>010</provincia>
			</xsl:when>
			<xsl:when test=". = 'MONEGLIA'">
				<comune>010037</comune>
				<provincia>010</provincia>
			</xsl:when>
			<xsl:when test=". = 'MONTEBRUNO'">
				<comune>010038</comune>
				<provincia>010</provincia>
			</xsl:when>
			<xsl:when test=". = 'MONTOGGIO'">
				<comune>010039</comune>
				<provincia>010</provincia>
			</xsl:when>
			<xsl:when test=". = 'NE'">
				<comune>010040</comune>
				<provincia>010</provincia>
			</xsl:when>
			<xsl:when test=". = 'NEIRONE'">
				<comune>010041</comune>
				<provincia>010</provincia>
			</xsl:when>
			<xsl:when test=". = 'ORERO'">
				<comune>010042</comune>
				<provincia>010</provincia>
			</xsl:when>
			<xsl:when test=". = 'PIEVE LIGURE'">
				<comune>010043</comune>
				<provincia>010</provincia>
			</xsl:when>
			<xsl:when test=". = 'PORTOFINO'">
				<comune>010044</comune>
				<provincia>010</provincia>
			</xsl:when>
			<xsl:when test=". = 'PROPATA'">
				<comune>010045</comune>
				<provincia>010</provincia>
			</xsl:when>
			<xsl:when test=". = 'RAPALLO'">
				<comune>010046</comune>
				<provincia>010</provincia>
			</xsl:when>
			<xsl:when test=". = 'RECCO'">
				<comune>010047</comune>
				<provincia>010</provincia>
			</xsl:when>
			<xsl:when test=". = 'REZZOAGLIO'">
				<comune>010048</comune>
				<provincia>010</provincia>
			</xsl:when>
			<xsl:when test=". = 'RONCO SCRIVIA'">
				<comune>010049</comune>
				<provincia>010</provincia>
			</xsl:when>
			<xsl:when test=". = 'RONDANINA'">
				<comune>010050</comune>
				<provincia>010</provincia>
			</xsl:when>
			<xsl:when test=". = 'ROSSIGLIONE'">
				<comune>010051</comune>
				<provincia>010</provincia>
			</xsl:when>
			<xsl:when test=". = 'ROVEGNO'">
				<comune>010052</comune>
				<provincia>010</provincia>
			</xsl:when>
			<xsl:when test=". = 'SAN COLOMBANO CERTENOLI'">
				<comune>010053</comune>
				<provincia>010</provincia>
			</xsl:when>
			<xsl:when test=". = 'SANTA MARGHERITA LIGURE'">
				<comune>010054</comune>
				<provincia>010</provincia>
			</xsl:when>
			<xsl:when test=". = 'SANT&amp;apos;OLCESE'">
				<comune>010055</comune>
				<provincia>010</provincia>
			</xsl:when>
			<xsl:when test=". = 'SANTO STEFANO D&amp;apos;AVETO'">
				<comune>010056</comune>
				<provincia>010</provincia>
			</xsl:when>
			<xsl:when test=". = 'SAVIGNONE'">
				<comune>010057</comune>
				<provincia>010</provincia>
			</xsl:when>
			<xsl:when test="starts-with(., 'SERRA RICC')">
				<comune>010058</comune>
				<provincia>010</provincia>
			</xsl:when>
			<xsl:when test=". = 'SESTRI LEVANTE'">
				<comune>010059</comune>
				<provincia>010</provincia>
			</xsl:when>
			<xsl:when test=". = 'SORI'">
				<comune>010060</comune>
				<provincia>010</provincia>
			</xsl:when>
			<xsl:when test=". = 'TIGLIETO'">
				<comune>010061</comune>
				<provincia>010</provincia>
			</xsl:when>
			<xsl:when test=". = 'TORRIGLIA'">
				<comune>010062</comune>
				<provincia>010</provincia>
			</xsl:when>
			<xsl:when test=". = 'TRIBOGNA'">
				<comune>010063</comune>
				<provincia>010</provincia>
			</xsl:when>
			<xsl:when test=". = 'USCIO'">
				<comune>010064</comune>
				<provincia>010</provincia>
			</xsl:when>
			<xsl:when test=". = 'VALBREVENNA'">
				<comune>010065</comune>
				<provincia>010</provincia>
			</xsl:when>
			<xsl:when test=". = 'VOBBIA'">
				<comune>010066</comune>
				<provincia>010</provincia>
			</xsl:when>
			<xsl:when test=". = 'ZOAGLI'">
				<comune>010067</comune>
				<provincia>010</provincia>
			</xsl:when>
			<xsl:when test=". = 'AMEGLIA'">
				<comune>011001</comune>
				<provincia>011</provincia>
			</xsl:when>
			<xsl:when test=". = 'ARCOLA'">
				<comune>011002</comune>
				<provincia>011</provincia>
			</xsl:when>
			<xsl:when test=". = 'BEVERINO'">
				<comune>011003</comune>
				<provincia>011</provincia>
			</xsl:when>
			<xsl:when test=". = 'BOLANO'">
				<comune>011004</comune>
				<provincia>011</provincia>
			</xsl:when>
			<xsl:when test=". = 'BONASSOLA'">
				<comune>011005</comune>
				<provincia>011</provincia>
			</xsl:when>
			<xsl:when test=". = 'BORGHETTO DI VARA'">
				<comune>011006</comune>
				<provincia>011</provincia>
			</xsl:when>
			<xsl:when test=". = 'BRUGNATO'">
				<comune>011007</comune>
				<provincia>011</provincia>
			</xsl:when>
			<xsl:when test=". = 'CALICE AL CORNOVIGLIO'">
				<comune>011008</comune>
				<provincia>011</provincia>
			</xsl:when>
			<xsl:when test=". = 'CARRO'">
				<comune>011009</comune>
				<provincia>011</provincia>
			</xsl:when>
			<xsl:when test=". = 'CARRODANO'">
				<comune>011010</comune>
				<provincia>011</provincia>
			</xsl:when>
			<xsl:when test=". = 'CASTELNUOVO MAGRA'">
				<comune>011011</comune>
				<provincia>011</provincia>
			</xsl:when>
			<xsl:when test=". = 'DEIVA MARINA'">
				<comune>011012</comune>
				<provincia>011</provincia>
			</xsl:when>
			<xsl:when test=". = 'FOLLO'">
				<comune>011013</comune>
				<provincia>011</provincia>
			</xsl:when>
			<xsl:when test=". = 'FRAMURA'">
				<comune>011014</comune>
				<provincia>011</provincia>
			</xsl:when>
			<xsl:when test=". = 'LA SPEZIA'">
				<comune>011015</comune>
				<provincia>011</provincia>
			</xsl:when>
			<xsl:when test=". = 'LERICI'">
				<comune>011016</comune>
				<provincia>011</provincia>
			</xsl:when>
			<xsl:when test=". = 'LEVANTO'">
				<comune>011017</comune>
				<provincia>011</provincia>
			</xsl:when>
			<xsl:when test=". = 'MAISSANA'">
				<comune>011018</comune>
				<provincia>011</provincia>
			</xsl:when>
			<xsl:when test=". = 'MONTEROSSO AL MARE'">
				<comune>011019</comune>
				<provincia>011</provincia>
			</xsl:when>
			<xsl:when test=". = 'ORTONOVO'">
				<comune>011020</comune>
				<provincia>011</provincia>
			</xsl:when>
			<xsl:when test=". = 'PIGNONE'">
				<comune>011021</comune>
				<provincia>011</provincia>
			</xsl:when>
			<xsl:when test=". = 'PORTOVENERE'">
				<comune>011022</comune>
				<provincia>011</provincia>
			</xsl:when>
			<xsl:when test="starts-with(., 'RICCO')">
				<comune>011023</comune>
				<provincia>011</provincia>
			</xsl:when>
			<xsl:when test=". = 'RIOMAGGIORE'">
				<comune>011024</comune>
				<provincia>011</provincia>
			</xsl:when>
			<xsl:when test=". = 'ROCCHETTA DI VARA'">
				<comune>011025</comune>
				<provincia>011</provincia>
			</xsl:when>
			<xsl:when test=". = 'SANTO STEFANO DI MAGRA'">
				<comune>011026</comune>
				<provincia>011</provincia>
			</xsl:when>
			<xsl:when test=". = 'SARZANA'">
				<comune>011027</comune>
				<provincia>011</provincia>
			</xsl:when>
			<xsl:when test=". = 'SESTA GODANO'">
				<comune>011028</comune>
				<provincia>011</provincia>
			</xsl:when>
			<xsl:when test=". = 'VARESE LIGURE'">
				<comune>011029</comune>
				<provincia>011</provincia>
			</xsl:when>
			<xsl:when test=". = 'VERNAZZA'">
				<comune>011030</comune>
				<provincia>011</provincia>
			</xsl:when>
			<xsl:when test=". = 'VEZZANO LIGURE'">
				<comune>011031</comune>
				<provincia>011</provincia>
			</xsl:when>
			<xsl:when test=". = 'ZIGNAGO'">
				<comune>011032</comune>
				<provincia>011</provincia>
			</xsl:when>
			<!-- Non può esserci otherwise, perché non si può inventare una provincia 
				e mappare anche quelle sarebbe seccante -->
			<!-- <xsl:otherwise> <comune><xsl:value-of select="."/></comune> </xsl:otherwise> -->
		</xsl:choose>
	</xsl:template>
	<!-- TODO: Auto-generated template -->
</xsl:stylesheet>