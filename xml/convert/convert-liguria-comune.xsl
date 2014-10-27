<?xml version="1.0" ?>
<xsl:stylesheet version="1.0"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="xml" indent="yes" />

	<xsl:template match="//scheda_BIBLIO/RECAPITI/COMUNE">
		<xsl:element name="comune">
			<xsl:choose>
<xsl:when test=". = 'AIROLE'">008001</xsl:when>
<xsl:when test=". = 'APRICALE'">008002</xsl:when>
<xsl:when test=". = 'AQUILA D&amp;apos;ARROSCIA'">008003</xsl:when>
<xsl:when test=". = 'ARMO'">008004</xsl:when>
<xsl:when test=". = 'AURIGO'">008005</xsl:when>
<xsl:when test=". = 'BADALUCCO'">008006</xsl:when>
<xsl:when test=". = 'BAJARDO'">008007</xsl:when>
<xsl:when test=". = 'BAIARDO'">008007</xsl:when>
<xsl:when test=". = 'BORDIGHERA'">008008</xsl:when>
<xsl:when test=". = 'BORGHETTO D&amp;apos;ARROSCIA'">008009</xsl:when>
<xsl:when test=". = 'BORGOMARO'">008010</xsl:when>
<xsl:when test=". = 'CAMPOROSSO'">008011</xsl:when>
<xsl:when test=". = 'CARAVONICA'">008012</xsl:when>
<xsl:when test=". = 'CARPASIO'">008013</xsl:when>
<xsl:when test=". = 'CASTELLARO'">008014</xsl:when>
<xsl:when test=". = 'CASTEL VITTORIO'">008015</xsl:when>
<xsl:when test=". = 'CERIANA'">008016</xsl:when>
<xsl:when test=". = 'CERVO'">008017</xsl:when>
<xsl:when test=". = 'CESIO'">008018</xsl:when>
<xsl:when test=". = 'CHIUSANICO'">008019</xsl:when>
<xsl:when test=". = 'CHIUSAVECCHIA'">008020</xsl:when>
<xsl:when test=". = 'CIPRESSA'">008021</xsl:when>
<xsl:when test=". = 'CIVEZZA'">008022</xsl:when>
<xsl:when test=". = 'COSIO D&amp;apos;ARROSCIA'">008023</xsl:when>
<xsl:when test=". = 'COSTARAINERA'">008024</xsl:when>
<xsl:when test=". = 'DIANO ARENTINO'">008025</xsl:when>
<xsl:when test=". = 'DIANO CASTELLO'">008026</xsl:when>
<xsl:when test=". = 'DIANO MARINA'">008027</xsl:when>
<xsl:when test=". = 'DIANO SAN PIETRO'">008028</xsl:when>
<xsl:when test=". = 'DOLCEACQUA'">008029</xsl:when>
<xsl:when test=". = 'DOLCEDO'">008030</xsl:when>
<xsl:when test=". = 'IMPERIA'">008031</xsl:when>
<xsl:when test=". = 'ISOLABONA'">008032</xsl:when>
<xsl:when test=". = 'LUCINASCO'">008033</xsl:when>
<xsl:when test=". = 'MENDATICA'">008034</xsl:when>
<xsl:when test=". = 'MOLINI DI TRIORA'">008035</xsl:when>
<xsl:when test=". = 'MONTALTO LIGURE'">008036</xsl:when>
<xsl:when test=". = 'MONTEGROSSO PIAN LATTE'">008037</xsl:when>
<xsl:when test=". = 'OLIVETTA SAN MICHELE'">008038</xsl:when>
<xsl:when test=". = 'OSPEDALETTI'">008039</xsl:when>
<xsl:when test=". = 'PERINALDO'">008040</xsl:when>
<xsl:when test=". = 'PIETRABRUNA'">008041</xsl:when>
<xsl:when test=". = 'PIEVE DI TECO'">008042</xsl:when>
<xsl:when test=". = 'PIGNA'">008043</xsl:when>
<xsl:when test=". = 'POMPEIANA'">008044</xsl:when>
<xsl:when test=". = 'PONTEDASSIO'">008045</xsl:when>
<xsl:when test=". = 'PORNASSIO'">008046</xsl:when>
<xsl:when test=". = 'PRELÀ'">008047</xsl:when>
<xsl:when test=". = 'RANZO'">008048</xsl:when>
<xsl:when test=". = 'REZZO'">008049</xsl:when>
<xsl:when test=". = 'RIVA LIGURE'">008050</xsl:when>
<xsl:when test=". = 'ROCCHETTA NERVINA'">008051</xsl:when>
<xsl:when test=". = 'SAN BARTOLOMEO AL MARE'">008052</xsl:when>
<xsl:when test=". = 'SAN BIAGIO DELLA CIMA'">008053</xsl:when>
<xsl:when test=". = 'SAN LORENZO AL MARE'">008054</xsl:when>
<xsl:when test=". = 'SANREMO'">008055</xsl:when>
<xsl:when test=". = 'SAN REMO'">008055</xsl:when>
<xsl:when test=". = 'SANTO STEFANO AL MARE'">008056</xsl:when>
<xsl:when test=". = 'SEBORGA'">008057</xsl:when>
<xsl:when test=". = 'SOLDANO'">008058</xsl:when>
<xsl:when test=". = 'TAGGIA'">008059</xsl:when>
<xsl:when test=". = 'TERZORIO'">008060</xsl:when>
<xsl:when test=". = 'TRIORA'">008061</xsl:when>
<xsl:when test=". = 'VALLEBONA'">008062</xsl:when>
<xsl:when test=". = 'VALLECROSIA'">008063</xsl:when>
<xsl:when test=". = 'VASIA'">008064</xsl:when>
<xsl:when test=". = 'VENTIMIGLIA'">008065</xsl:when>
<xsl:when test=". = 'VESSALICO'">008066</xsl:when>
<xsl:when test=". = 'VILLA FARALDI'">008067</xsl:when>
<xsl:when test=". = 'ALASSIO'">009001</xsl:when>
<xsl:when test=". = 'ALBENGA'">009002</xsl:when>
<xsl:when test=". = 'ALBISSOLA MARINA'">009003</xsl:when>
<xsl:when test=". = 'ALBISOLA SUPERIORE'">009004</xsl:when>
<xsl:when test=". = 'ALTARE'">009005</xsl:when>
<xsl:when test=". = 'ANDORA'">009006</xsl:when>
<xsl:when test=". = 'ARNASCO'">009007</xsl:when>
<xsl:when test=". = 'BALESTRINO'">009008</xsl:when>
<xsl:when test=". = 'BARDINETO'">009009</xsl:when>
<xsl:when test=". = 'BERGEGGI'">009010</xsl:when>
<xsl:when test=". = 'BOISSANO'">009011</xsl:when>
<xsl:when test=". = 'BORGHETTO SANTO SPIRITO'">009012</xsl:when>
<xsl:when test=". = 'BORGIO VEREZZI'">009013</xsl:when>
<xsl:when test=". = 'BORMIDA'">009014</xsl:when>
<xsl:when test=". = 'CAIRO MONTENOTTE'">009015</xsl:when>
<xsl:when test=". = 'CALICE LIGURE'">009016</xsl:when>
<xsl:when test=". = 'CALIZZANO'">009017</xsl:when>
<xsl:when test=". = 'CARCARE'">009018</xsl:when>
<xsl:when test=". = 'CASANOVA LERRONE'">009019</xsl:when>
<xsl:when test=". = 'CASTELBIANCO'">009020</xsl:when>
<xsl:when test=". = 'CASTELVECCHIO DI ROCCA BARBENA'">009021</xsl:when>
<xsl:when test=". = 'CELLE LIGURE'">009022</xsl:when>
<xsl:when test=". = 'CENGIO'">009023</xsl:when>
<xsl:when test=". = 'CERIALE'">009024</xsl:when>
<xsl:when test=". = 'CISANO SUL NEVA'">009025</xsl:when>
<xsl:when test=". = 'COSSERIA'">009026</xsl:when>
<xsl:when test=". = 'DEGO'">009027</xsl:when>
<xsl:when test=". = 'ERLI'">009028</xsl:when>
<xsl:when test=". = 'FINALE LIGURE'">009029</xsl:when>
<xsl:when test=". = 'GARLENDA'">009030</xsl:when>
<xsl:when test=". = 'GIUSTENICE'">009031</xsl:when>
<xsl:when test=". = 'GIUSVALLA'">009032</xsl:when>
<xsl:when test=". = 'LAIGUEGLIA'">009033</xsl:when>
<xsl:when test=". = 'LOANO'">009034</xsl:when>
<xsl:when test=". = 'MAGLIOLO'">009035</xsl:when>
<xsl:when test=". = 'MALLARE'">009036</xsl:when>
<xsl:when test=". = 'MASSIMINO'">009037</xsl:when>
<xsl:when test=". = 'MILLESIMO'">009038</xsl:when>
<xsl:when test=". = 'MIOGLIA'">009039</xsl:when>
<xsl:when test=". = 'MURIALDO'">009040</xsl:when>
<xsl:when test=". = 'NASINO'">009041</xsl:when>
<xsl:when test=". = 'NOLI'">009042</xsl:when>
<xsl:when test=". = 'ONZO'">009043</xsl:when>
<xsl:when test=". = 'ORCO FEGLINO'">009044</xsl:when>
<xsl:when test=". = 'ORTOVERO'">009045</xsl:when>
<xsl:when test=". = 'OSIGLIA'">009046</xsl:when>
<xsl:when test=". = 'PALLARE'">009047</xsl:when>
<xsl:when test=". = 'PIANA CRIXIA'">009048</xsl:when>
<xsl:when test=". = 'PIETRA LIGURE'">009049</xsl:when>
<xsl:when test=". = 'PLODIO'">009050</xsl:when>
<xsl:when test=". = 'PONTINVREA'">009051</xsl:when>
<xsl:when test=". = 'QUILIANO'">009052</xsl:when>
<xsl:when test=". = 'RIALTO'">009053</xsl:when>
<xsl:when test=". = 'ROCCAVIGNALE'">009054</xsl:when>
<xsl:when test=". = 'SASSELLO'">009055</xsl:when>
<xsl:when test=". = 'SAVONA'">009056</xsl:when>
<xsl:when test=". = 'SPOTORNO'">009057</xsl:when>
<xsl:when test=". = 'STELLA'">009058</xsl:when>
<xsl:when test=". = 'STELLANELLO'">009059</xsl:when>
<xsl:when test=". = 'TESTICO'">009060</xsl:when>
<xsl:when test=". = 'TOIRANO'">009061</xsl:when>
<xsl:when test=". = 'TOVO SAN GIACOMO'">009062</xsl:when>
<xsl:when test=". = 'URBE'">009063</xsl:when>
<xsl:when test=". = 'VADO LIGURE'">009064</xsl:when>
<xsl:when test=". = 'VARAZZE'">009065</xsl:when>
<xsl:when test=". = 'VENDONE'">009066</xsl:when>
<xsl:when test=". = 'VEZZI PORTIO'">009067</xsl:when>
<xsl:when test=". = 'VILLANOVA D&amp;apos;ALBENGA'">009068</xsl:when>
<xsl:when test=". = 'ZUCCARELLO'">009069</xsl:when>
<xsl:when test=". = 'ARENZANO'">010001</xsl:when>
<xsl:when test=". = 'AVEGNO'">010002</xsl:when>
<xsl:when test=". = 'BARGAGLI'">010003</xsl:when>
<xsl:when test=". = 'BOGLIASCO'">010004</xsl:when>
<xsl:when test=". = 'BORZONASCA'">010005</xsl:when>
<xsl:when test=". = 'BUSALLA'">010006</xsl:when>
<xsl:when test=". = 'CAMOGLI'">010007</xsl:when>
<xsl:when test=". = 'CAMPO LIGURE'">010008</xsl:when>
<xsl:when test=". = 'CAMPOMORONE'">010009</xsl:when>
<xsl:when test=". = 'CARASCO'">010010</xsl:when>
<xsl:when test=". = 'CASARZA LIGURE'">010011</xsl:when>
<xsl:when test=". = 'CASELLA'">010012</xsl:when>
<xsl:when test=". = 'CASTIGLIONE CHIAVARESE'">010013</xsl:when>
<xsl:when test=". = 'CERANESI'">010014</xsl:when>
<xsl:when test=". = 'CHIAVARI'">010015</xsl:when>
<xsl:when test=". = 'CICAGNA'">010016</xsl:when>
<xsl:when test=". = 'COGOLETO'">010017</xsl:when>
<xsl:when test=". = 'COGORNO'">010018</xsl:when>
<xsl:when test=". = 'COREGLIA LIGURE'">010019</xsl:when>
<xsl:when test=". = 'CROCEFIESCHI'">010020</xsl:when>
<xsl:when test=". = 'DAVAGNA'">010021</xsl:when>
<xsl:when test=". = 'FASCIA'">010022</xsl:when>
<xsl:when test=". = 'FAVALE DI MALVARO'">010023</xsl:when>
<xsl:when test=". = 'FONTANIGORDA'">010024</xsl:when>
<xsl:when test=". = 'GENOVA'">010025</xsl:when>
<xsl:when test=". = 'GORRETO'">010026</xsl:when>
<xsl:when test=". = 'ISOLA DEL CANTONE'">010027</xsl:when>
<xsl:when test=". = 'LAVAGNA'">010028</xsl:when>
<xsl:when test=". = 'LEIVI'">010029</xsl:when>
<xsl:when test=". = 'LORSICA'">010030</xsl:when>
<xsl:when test=". = 'LUMARZO'">010031</xsl:when>
<xsl:when test=". = 'MASONE'">010032</xsl:when>
<xsl:when test=". = 'MELE'">010033</xsl:when>
<xsl:when test=". = 'MEZZANEGO'">010034</xsl:when>
<xsl:when test=". = 'MIGNANEGO'">010035</xsl:when>
<xsl:when test=". = 'MOCONESI'">010036</xsl:when>
<xsl:when test=". = 'MONEGLIA'">010037</xsl:when>
<xsl:when test=". = 'MONTEBRUNO'">010038</xsl:when>
<xsl:when test=". = 'MONTOGGIO'">010039</xsl:when>
<xsl:when test=". = 'NE'">010040</xsl:when>
<xsl:when test=". = 'NEIRONE'">010041</xsl:when>
<xsl:when test=". = 'ORERO'">010042</xsl:when>
<xsl:when test=". = 'PIEVE LIGURE'">010043</xsl:when>
<xsl:when test=". = 'PORTOFINO'">010044</xsl:when>
<xsl:when test=". = 'PROPATA'">010045</xsl:when>
<xsl:when test=". = 'RAPALLO'">010046</xsl:when>
<xsl:when test=". = 'RECCO'">010047</xsl:when>
<xsl:when test=". = 'REZZOAGLIO'">010048</xsl:when>
<xsl:when test=". = 'RONCO SCRIVIA'">010049</xsl:when>
<xsl:when test=". = 'RONDANINA'">010050</xsl:when>
<xsl:when test=". = 'ROSSIGLIONE'">010051</xsl:when>
<xsl:when test=". = 'ROVEGNO'">010052</xsl:when>
<xsl:when test=". = 'SAN COLOMBANO CERTENOLI'">010053</xsl:when>
<xsl:when test=". = 'SANTA MARGHERITA LIGURE'">010054</xsl:when>
<xsl:when test=". = 'SANT&amp;apos;OLCESE'">010055</xsl:when>
<xsl:when test=". = 'SANTO STEFANO D&amp;apos;AVETO'">010056</xsl:when>
<xsl:when test=". = 'SAVIGNONE'">010057</xsl:when>
<xsl:when test=". = 'SERRA RICCÒ'">010058</xsl:when>
<xsl:when test=". = 'SESTRI LEVANTE'">010059</xsl:when>
<xsl:when test=". = 'SORI'">010060</xsl:when>
<xsl:when test=". = 'TIGLIETO'">010061</xsl:when>
<xsl:when test=". = 'TORRIGLIA'">010062</xsl:when>
<xsl:when test=". = 'TRIBOGNA'">010063</xsl:when>
<xsl:when test=". = 'USCIO'">010064</xsl:when>
<xsl:when test=". = 'VALBREVENNA'">010065</xsl:when>
<xsl:when test=". = 'VOBBIA'">010066</xsl:when>
<xsl:when test=". = 'ZOAGLI'">010067</xsl:when>
<xsl:when test=". = 'AMEGLIA'">011001</xsl:when>
<xsl:when test=". = 'ARCOLA'">011002</xsl:when>
<xsl:when test=". = 'BEVERINO'">011003</xsl:when>
<xsl:when test=". = 'BOLANO'">011004</xsl:when>
<xsl:when test=". = 'BONASSOLA'">011005</xsl:when>
<xsl:when test=". = 'BORGHETTO DI VARA'">011006</xsl:when>
<xsl:when test=". = 'BRUGNATO'">011007</xsl:when>
<xsl:when test=". = 'CALICE AL CORNOVIGLIO'">011008</xsl:when>
<xsl:when test=". = 'CARRO'">011009</xsl:when>
<xsl:when test=". = 'CARRODANO'">011010</xsl:when>
<xsl:when test=". = 'CASTELNUOVO MAGRA'">011011</xsl:when>
<xsl:when test=". = 'DEIVA MARINA'">011012</xsl:when>
<xsl:when test=". = 'FOLLO'">011013</xsl:when>
<xsl:when test=". = 'FRAMURA'">011014</xsl:when>
<xsl:when test=". = 'LA SPEZIA'">011015</xsl:when>
<xsl:when test=". = 'LERICI'">011016</xsl:when>
<xsl:when test=". = 'LEVANTO'">011017</xsl:when>
<xsl:when test=". = 'MAISSANA'">011018</xsl:when>
<xsl:when test=". = 'MONTEROSSO AL MARE'">011019</xsl:when>
<xsl:when test=". = 'ORTONOVO'">011020</xsl:when>
<xsl:when test=". = 'PIGNONE'">011021</xsl:when>
<xsl:when test=". = 'PORTOVENERE'">011022</xsl:when>
<xsl:when test=". = 'RICCÒ DEL GOLFO DI SPEZIA'">011023</xsl:when>
<xsl:when test=". = 'RICCO&amp;apos; DEL GOLFO DI SPEZIA'">011023</xsl:when>
<xsl:when test=". = 'RIOMAGGIORE'">011024</xsl:when>
<xsl:when test=". = 'ROCCHETTA DI VARA'">011025</xsl:when>
<xsl:when test=". = 'SANTO STEFANO DI MAGRA'">011026</xsl:when>
<xsl:when test=". = 'SARZANA'">011027</xsl:when>
<xsl:when test=". = 'SESTA GODANO'">011028</xsl:when>
<xsl:when test=". = 'VARESE LIGURE'">011029</xsl:when>
<xsl:when test=". = 'VERNAZZA'">011030</xsl:when>
<xsl:when test=". = 'VEZZANO LIGURE'">011031</xsl:when>
<xsl:when test=". = 'ZIGNAGO'">011032</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="."/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:element>
	</xsl:template>
	<!-- TODO: Auto-generated template -->
</xsl:stylesheet>