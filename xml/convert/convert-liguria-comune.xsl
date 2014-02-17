<?xml version="1.0" ?>
<xsl:stylesheet version="1.0"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="xml" indent="yes" />

	<xsl:template match="//scheda_BIBLIO/RECAPITI/COMUNE">
		<xsl:element name="comune">
			<xsl:choose>
<xsl:when test=". = 'AIROLE'">008001</xsl:when>
<xsl:when test=". = 'ALASSIO'">008002</xsl:when>
<xsl:when test=". = 'ALBENGA'">008003</xsl:when>
<xsl:when test=". = 'ALBISOLA SUPERIORE'">008004</xsl:when>
<xsl:when test=". = 'ALBISSOLA MARINA'">008005</xsl:when>
<xsl:when test=". = 'ALTARE'">008006</xsl:when>
<xsl:when test=". = 'AMEGLIA'">008007</xsl:when>
<xsl:when test=". = 'ANDORA'">008008</xsl:when>
<xsl:when test=". = 'APRICALE'">008009</xsl:when>
<xsl:when test=". = 'AQUILA D&amp;apos;ARROSCIA'">008010</xsl:when>
<xsl:when test=". = 'ARCOLA'">008011</xsl:when>
<xsl:when test=". = 'ARENZANO'">008012</xsl:when>
<xsl:when test=". = 'ARMO'">008013</xsl:when>
<xsl:when test=". = 'ARNASCO'">008014</xsl:when>
<xsl:when test=". = 'AURIGO'">008015</xsl:when>
<xsl:when test=". = 'AVEGNO'">008016</xsl:when>
<xsl:when test=". = 'BADALUCCO'">008017</xsl:when>
<xsl:when test=". = 'BAJARDO'">008018</xsl:when>
<xsl:when test=". = 'BALESTRINO'">008019</xsl:when>
<xsl:when test=". = 'BARDINETO'">008020</xsl:when>
<xsl:when test=". = 'BARGAGLI'">008021</xsl:when>
<xsl:when test=". = 'BERGEGGI'">008022</xsl:when>
<xsl:when test=". = 'BEVERINO'">008023</xsl:when>
<xsl:when test=". = 'BOGLIASCO'">008024</xsl:when>
<xsl:when test=". = 'BOISSANO'">008025</xsl:when>
<xsl:when test=". = 'BOLANO'">008026</xsl:when>
<xsl:when test=". = 'BONASSOLA'">008027</xsl:when>
<xsl:when test=". = 'BORDIGHERA'">008028</xsl:when>
<xsl:when test=". = 'BORGHETTO D&amp;apos;ARROSCIA'">008029</xsl:when>
<xsl:when test=". = 'BORGHETTO DI VARA'">008030</xsl:when>
<xsl:when test=". = 'BORGHETTO SANTO SPIRITO'">008031</xsl:when>
<xsl:when test=". = 'BORGIO VEREZZI'">008032</xsl:when>
<xsl:when test=". = 'BORGOMARO'">008033</xsl:when>
<xsl:when test=". = 'BORMIDA'">008034</xsl:when>
<xsl:when test=". = 'BORZONASCA'">008035</xsl:when>
<xsl:when test=". = 'BRUGNATO'">008036</xsl:when>
<xsl:when test=". = 'BUSALLA'">008037</xsl:when>
<xsl:when test=". = 'CAIRO MONTENOTTE'">008038</xsl:when>
<xsl:when test=". = 'CALICE AL CORNOVIGLIO'">008039</xsl:when>
<xsl:when test=". = 'CALICE LIGURE'">008040</xsl:when>
<xsl:when test=". = 'CALIZZANO'">008041</xsl:when>
<xsl:when test=". = 'CAMOGLI'">008042</xsl:when>
<xsl:when test=". = 'CAMPO LIGURE'">008043</xsl:when>
<xsl:when test=". = 'CAMPOMORONE'">008044</xsl:when>
<xsl:when test=". = 'CAMPOROSSO'">008045</xsl:when>
<xsl:when test=". = 'CARASCO'">008046</xsl:when>
<xsl:when test=". = 'CARAVONICA'">008047</xsl:when>
<xsl:when test=". = 'CARCARE'">008048</xsl:when>
<xsl:when test=". = 'CARPASIO'">008049</xsl:when>
<xsl:when test=". = 'CARRO'">008050</xsl:when>
<xsl:when test=". = 'CARRODANO'">008051</xsl:when>
<xsl:when test=". = 'CASANOVA LERRONE'">008052</xsl:when>
<xsl:when test=". = 'CASARZA LIGURE'">008053</xsl:when>
<xsl:when test=". = 'CASELLA'">008054</xsl:when>
<xsl:when test=". = 'CASTEL VITTORIO'">008055</xsl:when>
<xsl:when test=". = 'CASTELBIANCO'">008056</xsl:when>
<xsl:when test=". = 'CASTELLARO'">008057</xsl:when>
<xsl:when test=". = 'CASTELNUOVO MAGRA'">008058</xsl:when>
<xsl:when test=". = 'CASTELVECCHIO DI ROCCA BARBENA'">008059</xsl:when>
<xsl:when test=". = 'CASTIGLIONE CHIAVARESE'">008060</xsl:when>
<xsl:when test=". = 'CELLE LIGURE'">008061</xsl:when>
<xsl:when test=". = 'CENGIO'">008062</xsl:when>
<xsl:when test=". = 'CERANESI'">008063</xsl:when>
<xsl:when test=". = 'CERIALE'">008064</xsl:when>
<xsl:when test=". = 'CERIANA'">008065</xsl:when>
<xsl:when test=". = 'CERVO'">008066</xsl:when>
<xsl:when test=". = 'CESIO'">008067</xsl:when>
<xsl:when test=". = 'CHIAVARI'">009001</xsl:when>
<xsl:when test=". = 'CHIUSANICO'">009002</xsl:when>
<xsl:when test=". = 'CHIUSAVECCHIA'">009003</xsl:when>
<xsl:when test=". = 'CICAGNA'">009004</xsl:when>
<xsl:when test=". = 'CIPRESSA'">009005</xsl:when>
<xsl:when test=". = 'CISANO SUL NEVA'">009006</xsl:when>
<xsl:when test=". = 'CIVEZZA'">009007</xsl:when>
<xsl:when test=". = 'COGOLETO'">009008</xsl:when>
<xsl:when test=". = 'COGORNO'">009009</xsl:when>
<xsl:when test=". = 'COREGLIA LIGURE'">009010</xsl:when>
<xsl:when test=". = 'COSIO D&amp;apos;ARROSCIA'">009011</xsl:when>
<xsl:when test=". = 'COSSERIA'">009012</xsl:when>
<xsl:when test=". = 'COSTARAINERA'">009013</xsl:when>
<xsl:when test=". = 'CROCEFIESCHI'">009014</xsl:when>
<xsl:when test=". = 'DAVAGNA'">009015</xsl:when>
<xsl:when test=". = 'DEGO'">009016</xsl:when>
<xsl:when test=". = 'DEIVA MARINA'">009017</xsl:when>
<xsl:when test=". = 'DIANO ARENTINO'">009018</xsl:when>
<xsl:when test=". = 'DIANO CASTELLO'">009019</xsl:when>
<xsl:when test=". = 'DIANO MARINA'">009020</xsl:when>
<xsl:when test=". = 'DIANO SAN PIETRO'">009021</xsl:when>
<xsl:when test=". = 'DOLCEACQUA'">009022</xsl:when>
<xsl:when test=". = 'DOLCEDO'">009023</xsl:when>
<xsl:when test=". = 'ERLI'">009024</xsl:when>
<xsl:when test=". = 'FASCIA'">009025</xsl:when>
<xsl:when test=". = 'FAVALE DI MALVARO'">009026</xsl:when>
<xsl:when test=". = 'FINALE LIGURE'">009027</xsl:when>
<xsl:when test=". = 'FOLLO'">009028</xsl:when>
<xsl:when test=". = 'FONTANIGORDA'">009029</xsl:when>
<xsl:when test=". = 'FRAMURA'">009030</xsl:when>
<xsl:when test=". = 'GARLENDA'">009031</xsl:when>
<xsl:when test=". = 'GENOVA'">009032</xsl:when>
<xsl:when test=". = 'GIUSTENICE'">009033</xsl:when>
<xsl:when test=". = 'GIUSVALLA'">009034</xsl:when>
<xsl:when test=". = 'GORRETO'">009035</xsl:when>
<xsl:when test=". = 'IMPERIA'">009036</xsl:when>
<xsl:when test=". = 'ISOLA DEL CANTONE'">009037</xsl:when>
<xsl:when test=". = 'ISOLABONA'">009038</xsl:when>
<xsl:when test=". = 'LA SPEZIA'">009039</xsl:when>
<xsl:when test=". = 'LAIGUEGLIA'">009040</xsl:when>
<xsl:when test=". = 'LAVAGNA'">009041</xsl:when>
<xsl:when test=". = 'LEIVI'">009042</xsl:when>
<xsl:when test=". = 'LERICI'">009043</xsl:when>
<xsl:when test=". = 'LEVANTO'">009044</xsl:when>
<xsl:when test=". = 'LOANO'">009045</xsl:when>
<xsl:when test=". = 'LORSICA'">009046</xsl:when>
<xsl:when test=". = 'LUCINASCO'">009047</xsl:when>
<xsl:when test=". = 'LUMARZO'">009048</xsl:when>
<xsl:when test=". = 'MAGLIOLO'">009049</xsl:when>
<xsl:when test=". = 'MAISSANA'">009050</xsl:when>
<xsl:when test=". = 'MALLARE'">009051</xsl:when>
<xsl:when test=". = 'MASONE'">009052</xsl:when>
<xsl:when test=". = 'MASSIMINO'">009053</xsl:when>
<xsl:when test=". = 'MELE'">009054</xsl:when>
<xsl:when test=". = 'MENDATICA'">009055</xsl:when>
<xsl:when test=". = 'MEZZANEGO'">009056</xsl:when>
<xsl:when test=". = 'MIGNANEGO'">009057</xsl:when>
<xsl:when test=". = 'MILLESIMO'">009058</xsl:when>
<xsl:when test=". = 'MIOGLIA'">009059</xsl:when>
<xsl:when test=". = 'MOCONESI'">009060</xsl:when>
<xsl:when test=". = 'MOLINI DI TRIORA'">009061</xsl:when>
<xsl:when test=". = 'MONEGLIA'">009062</xsl:when>
<xsl:when test=". = 'MONTALTO LIGURE'">009063</xsl:when>
<xsl:when test=". = 'MONTEBRUNO'">009064</xsl:when>
<xsl:when test=". = 'MONTEGROSSO PIAN LATTE'">009065</xsl:when>
<xsl:when test=". = 'MONTEROSSO AL MARE'">009066</xsl:when>
<xsl:when test=". = 'MONTOGGIO'">009067</xsl:when>
<xsl:when test=". = 'MURIALDO'">009068</xsl:when>
<xsl:when test=". = 'NASINO'">009069</xsl:when>
<xsl:when test=". = 'NE'">010001</xsl:when>
<xsl:when test=". = 'NEIRONE'">010002</xsl:when>
<xsl:when test=". = 'NOLI'">010003</xsl:when>
<xsl:when test=". = 'OLIVETTA SAN MICHELE'">010004</xsl:when>
<xsl:when test=". = 'ONZO'">010005</xsl:when>
<xsl:when test=". = 'ORCO FEGLINO'">010006</xsl:when>
<xsl:when test=". = 'ORERO'">010007</xsl:when>
<xsl:when test=". = 'ORTONOVO'">010008</xsl:when>
<xsl:when test=". = 'ORTOVERO'">010009</xsl:when>
<xsl:when test=". = 'OSIGLIA'">010010</xsl:when>
<xsl:when test=". = 'OSPEDALETTI'">010011</xsl:when>
<xsl:when test=". = 'PALLARE'">010012</xsl:when>
<xsl:when test=". = 'PERINALDO'">010013</xsl:when>
<xsl:when test=". = 'PIANA CRIXIA'">010014</xsl:when>
<xsl:when test=". = 'PIETRA LIGURE'">010015</xsl:when>
<xsl:when test=". = 'PIETRABRUNA'">010016</xsl:when>
<xsl:when test=". = 'PIEVE DI TECO'">010017</xsl:when>
<xsl:when test=". = 'PIEVE LIGURE'">010018</xsl:when>
<xsl:when test=". = 'PIGNA'">010019</xsl:when>
<xsl:when test=". = 'PIGNONE'">010020</xsl:when>
<xsl:when test=". = 'PLODIO'">010021</xsl:when>
<xsl:when test=". = 'POMPEIANA'">010022</xsl:when>
<xsl:when test=". = 'PONTEDASSIO'">010023</xsl:when>
<xsl:when test=". = 'PONTINVREA'">010024</xsl:when>
<xsl:when test=". = 'PORNASSIO'">010025</xsl:when>
<xsl:when test=". = 'PORTOFINO'">010026</xsl:when>
<xsl:when test=". = 'PORTOVENERE'">010027</xsl:when>
<xsl:when test=". = 'PRELÀ'">010028</xsl:when>
<xsl:when test=". = 'PROPATA'">010029</xsl:when>
<xsl:when test=". = 'QUILIANO'">010030</xsl:when>
<xsl:when test=". = 'RANZO'">010031</xsl:when>
<xsl:when test=". = 'RAPALLO'">010032</xsl:when>
<xsl:when test=". = 'RECCO'">010033</xsl:when>
<xsl:when test=". = 'REZZO'">010034</xsl:when>
<xsl:when test=". = 'REZZOAGLIO'">010035</xsl:when>
<xsl:when test=". = 'RIALTO'">010036</xsl:when>
<xsl:when test=". = 'RICCÒ DEL GOLFO DI SPEZIA'">010037</xsl:when>
<xsl:when test=". = 'RIOMAGGIORE'">010038</xsl:when>
<xsl:when test=". = 'RIVA LIGURE'">010039</xsl:when>
<xsl:when test=". = 'ROCCAVIGNALE'">010040</xsl:when>
<xsl:when test=". = 'ROCCHETTA DI VARA'">010041</xsl:when>
<xsl:when test=". = 'ROCCHETTA NERVINA'">010042</xsl:when>
<xsl:when test=". = 'RONCO SCRIVIA'">010043</xsl:when>
<xsl:when test=". = 'RONDANINA'">010044</xsl:when>
<xsl:when test=". = 'ROSSIGLIONE'">010045</xsl:when>
<xsl:when test=". = 'ROVEGNO'">010046</xsl:when>
<xsl:when test=". = 'SAN BARTOLOMEO AL MARE'">010047</xsl:when>
<xsl:when test=". = 'SAN BIAGIO DELLA CIMA'">010048</xsl:when>
<xsl:when test=". = 'SAN COLOMBANO CERTENOLI'">010049</xsl:when>
<xsl:when test=". = 'SAN LORENZO AL MARE'">010050</xsl:when>
<xsl:when test=". = 'SANREMO'">010051</xsl:when>
<xsl:when test=". = 'SANTA MARGHERITA LIGURE'">010052</xsl:when>
<xsl:when test=". = 'SANTO STEFANO AL MARE'">010053</xsl:when>
<xsl:when test=". = 'SANTO STEFANO D&amp;apos;AVETO'">010054</xsl:when>
<xsl:when test=". = 'SANTO STEFANO DI MAGRA'">010055</xsl:when>
<xsl:when test=". = 'SANT&amp;apos;OLCESE'">010056</xsl:when>
<xsl:when test=". = 'SARZANA'">010057</xsl:when>
<xsl:when test=". = 'SASSELLO'">010058</xsl:when>
<xsl:when test=". = 'SAVIGNONE'">010059</xsl:when>
<xsl:when test=". = 'SAVONA'">010060</xsl:when>
<xsl:when test=". = 'SEBORGA'">010061</xsl:when>
<xsl:when test=". = 'SERRA RICCÒ'">010062</xsl:when>
<xsl:when test=". = 'SESTA GODANO'">010063</xsl:when>
<xsl:when test=". = 'SESTRI LEVANTE'">010064</xsl:when>
<xsl:when test=". = 'SOLDANO'">010065</xsl:when>
<xsl:when test=". = 'SORI'">010066</xsl:when>
<xsl:when test=". = 'SPOTORNO'">010067</xsl:when>
<xsl:when test=". = 'STELLA'">011001</xsl:when>
<xsl:when test=". = 'STELLANELLO'">011002</xsl:when>
<xsl:when test=". = 'TAGGIA'">011003</xsl:when>
<xsl:when test=". = 'TERZORIO'">011004</xsl:when>
<xsl:when test=". = 'TESTICO'">011005</xsl:when>
<xsl:when test=". = 'TIGLIETO'">011006</xsl:when>
<xsl:when test=". = 'TOIRANO'">011007</xsl:when>
<xsl:when test=". = 'TORRIGLIA'">011008</xsl:when>
<xsl:when test=". = 'TOVO SAN GIACOMO'">011009</xsl:when>
<xsl:when test=". = 'TRIBOGNA'">011010</xsl:when>
<xsl:when test=". = 'TRIORA'">011011</xsl:when>
<xsl:when test=". = 'URBE'">011012</xsl:when>
<xsl:when test=". = 'USCIO'">011013</xsl:when>
<xsl:when test=". = 'VADO LIGURE'">011014</xsl:when>
<xsl:when test=". = 'VALBREVENNA'">011015</xsl:when>
<xsl:when test=". = 'VALLEBONA'">011016</xsl:when>
<xsl:when test=". = 'VALLECROSIA'">011017</xsl:when>
<xsl:when test=". = 'VARAZZE'">011018</xsl:when>
<xsl:when test=". = 'VARESE LIGURE'">011019</xsl:when>
<xsl:when test=". = 'VASIA'">011020</xsl:when>
<xsl:when test=". = 'VENDONE'">011021</xsl:when>
<xsl:when test=". = 'VENTIMIGLIA'">011022</xsl:when>
<xsl:when test=". = 'VERNAZZA'">011023</xsl:when>
<xsl:when test=". = 'VESSALICO'">011024</xsl:when>
<xsl:when test=". = 'VEZZANO LIGURE'">011025</xsl:when>
<xsl:when test=". = 'VEZZI PORTIO'">011026</xsl:when>
<xsl:when test=". = 'VILLA FARALDI'">011027</xsl:when>
<xsl:when test=". = 'VILLANOVA D&amp;apos;ALBENGA'">011028</xsl:when>
<xsl:when test=". = 'VOBBIA'">011029</xsl:when>
<xsl:when test=". = 'ZIGNAGO'">011030</xsl:when>
<xsl:when test=". = 'ZOAGLI'">011031</xsl:when>
<xsl:when test=". = 'ZUCCARELLO'">011032</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="."/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:element>
	</xsl:template>
	<!-- TODO: Auto-generated template -->
</xsl:stylesheet>