<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	version="1.0">

<!--
	Foglio di stile per correggere piccoli difetti nei file 1.6 inviati
	dalla Regione Campania. È sostanzialmente un "copy with recursion" con
	l'aggiunta di template per i vari elementi da correggere.
	Inoltre esclude le biblioteche di fonte AICE.
-->

	<xsl:output method="xml" indent="yes" encoding="UTF-8" />

<!-- 
	Questo è l'identity transform che garantisce che tutto ciò per cui non
	è definito un template viene semplicemente copiato in output
-->
	<xsl:template match="@*|node()">
		<xsl:copy>
			<xsl:apply-templates select="@*|node()" />
		</xsl:copy>
	</xsl:template>

<!-- Per escludere le biblioteche di fonte CEI, senza però rischiare di compromettere la copia
completa di tutte le altre, serve un primo template solo per escludere dall'output qualunque
cosa che non sia governato dal secondo, che copia una biblioteca non AICE per intero; vengongo
escluse anche le biblioteche di ente ecclesiastico, che saranno gestite caso per caso -->

	<xsl:template match="/biblioteche">
		<xsl:element name="biblioteche">
			<xsl:copy-of select="data-export" />
			<xsl:apply-templates select="//biblioteca"/>
		</xsl:element>
	</xsl:template>

	<xsl:template match="//biblioteca">
		<xsl:if test="not(contains(anagrafica/fonte/descrizione,'AICE'))">
<!-- questa versione esclude anche le ecclesiastiche, oltre alle AICE -->
<!-- 
		<xsl:if test="not(contains(anagrafica/fonte/descrizione,'AICE')) 
		and not(contains(amministrativa/ente/tipologia-amministrativa, 'Enti ecclesiastici'))">
 -->		
			<xsl:element name="biblioteca">
				<xsl:apply-templates select="*" />
			</xsl:element>
		</xsl:if>
	</xsl:template>

<!-- nell'anagrafica si inserisce il nuovo elemento fonte e si copia tutto il resto; si
presuppone che siano già state rimosse le biblioteche in carico ad AICE, ma questo è oggetto di
un altro foglio di stile, anche se si potrebbe includere qui la regola di esclusione -->

	<xsl:template match="//biblioteca/anagrafica">
		<xsl:element name="anagrafica">
			<xsl:copy-of select="data-censimento"/>
			<xsl:copy-of select="data-aggiornamento"/>
			<xsl:element name="fonte">
				<xsl:element name="descrizione">Regione Campania</xsl:element>
				<xsl:element name="url"/>
			</xsl:element>
			<xsl:copy-of select="nomi"/>
			<xsl:copy-of select="codici"/>
			<xsl:copy-of select="indirizzo"/>
			<xsl:copy-of select="contatti"/>
			<xsl:apply-templates select="edificio"/>
			<xsl:copy-of select="istituzione"/>
		</xsl:element>
	</xsl:template>

<!-- correzioni alle tipologie amministrative -->

	<xsl:template match="//tipologia-amministrativa">
		<xsl:choose>

		<xsl:when test="contains(.,'Ministero per i beni e le attivit')">
		<xsl:element name="tipologia-amministrativa">Ministero dei beni e delle attività culturali e del turismo</xsl:element>
		</xsl:when>

		<xsl:when test=". = 'Scuole primarie'">
		<xsl:element name="tipologia-amministrativa">Presidenza del consiglio dei ministri e ministeri</xsl:element>
		</xsl:when>

		<xsl:when test=". = 'Scuole secondarie superiori'">
		<xsl:element name="tipologia-amministrativa">Presidenza del consiglio dei ministri e ministeri</xsl:element>
		</xsl:when>

		<xsl:otherwise>
				<xsl:copy-of select="." />
		</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

<!-- correzioni alle tipologie funzionali -->

	<xsl:template match="//tipologia-funzionale">
		<xsl:choose>

		<xsl:when test="contains(.,'Universitaria')">
		<xsl:element name="tipologia-funzionale">Istituto di insegnamento superiore</xsl:element>
		</xsl:when>

		<xsl:otherwise>
				<xsl:copy-of select="." />
		</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

<!-- correzioni ai limiti di età -->

	<xsl:template match="//modalita-accesso/modo">
		<xsl:choose>

		<xsl:when test="contains(.,' > = 8')">
		<xsl:element name="modo">Limite di eta': >= 8</xsl:element>
		</xsl:when>

		<xsl:when test="contains(.,'Registrazione dati anagrafici')">
		<xsl:element name="modo">Registrazione</xsl:element>
		</xsl:when>

		<xsl:otherwise>
				<xsl:copy-of select="." />
		</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

<!-- c'è un sistema di biblioteche errato solo a causa di un apostrofo -->

	<xsl:template match="//sistemi/sistema">
		<xsl:choose>
		<xsl:when test="contains(.,'Ateneo. Università degli Studi di Salerno')">
		<xsl:element name="sistema">Sistema bibliotecario di Ateneo. Università degli Studi di Salerno</xsl:element>
		</xsl:when>
		<xsl:otherwise>
				<xsl:copy-of select="." />
		</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

<!-- sezioni speciali -->

	<xsl:template match="//sezioni-speciali/sezione">
		<xsl:choose>
		<xsl:when test="contains(.,'Sezione Raccolta storica di testi legislativi')">
		<xsl:element name="sezione">legislazione italiana</xsl:element>
		</xsl:when>
		<xsl:when test="contains(.,'dialettologia')">
		<xsl:element name="sezione">dialetto</xsl:element>
		</xsl:when>
		<xsl:when test="contains(.,'libro parlato')">
		<xsl:element name="sezione">audiolibri</xsl:element>
		</xsl:when>
		<xsl:when test="contains(.,'Fotodiapoteca')">
		<sezione>fotografia</sezione>
		<sezione>diapositive</sezione>
		</xsl:when>
		<xsl:otherwise>
				<xsl:copy-of select="." />
		</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

<!-- cataloghi collettivi, solo uno è da correggere -->

	<xsl:template match="//catalogo-collettivo/nome">
		<xsl:choose>
		<xsl:when test="contains(.,'Sistema bibliotecario di Ateneo. Università degli Studi di Napoli Federico 2°')">
		<xsl:element name="nome">Sistema bibliotecario di Ateneo. Università degli Studi di Napoli Federico II</xsl:element>
		</xsl:when>
		<xsl:otherwise>
				<xsl:copy-of select="." />
		</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

<!-- patrimonio -->

	<xsl:template match="//patrimonio/materiali/materiale/@nome">
		<xsl:choose>
		<xsl:when test="contains(.,'documenti multimediali')">
		<xsl:attribute name="nome">materiale multimediale</xsl:attribute>
		</xsl:when>
		<xsl:when test=". = 'musica'">
		<xsl:attribute name="nome">documenti musicali a stampa</xsl:attribute>
		</xsl:when>
		<xsl:otherwise>
				<xsl:copy-of select="." />
		</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

<!-- gli utenti del prestito locale andreanno scambiati a causa di un bug ancora
non risolto nell'applicativo regionale; in una prima fase si estrae solo 
"ultimo-anno", esportandolo però come "iscritti-prestito" -->

	<xsl:template match="//utenti">
	  <utenti>
		  <xsl:if test="ultimo-anno">
		  	<iscritti-prestito><xsl:value-of select="ultimo-anno"/></iscritti-prestito>
		  </xsl:if>
			<xsl:copy-of select="minori-quattordici-anni" />
		</utenti>
	</xsl:template>

<!-- 
forse per un bug o per una configurazione incompleta, la url delle immagini 
richiede l'inserimento di un ramo mancante; prima però serve un template per 
copiare gli altri dati dell'edificio
 -->

	<xsl:template match="edificio">
	  <edificio>
			<xsl:copy-of select="denominazione"/>
			<xsl:copy-of select="monumentale"/>
			<xsl:copy-of select="appositamente-costruito"/>
			<xsl:copy-of select="data-costruzione"/>
			<xsl:apply-templates select="immagini"/>
		</edificio>
	</xsl:template>

	<xsl:template match="immagini">
		<immagini>
	  <xsl:for-each select="immagine">
	  <immagine>
			<xsl:if test="starts-with(url, 'http://anagrafebiblioteche.regione.campania.it')">
				<url><xsl:value-of select="concat('http://anagrafebiblioteche.regione.campania.it/abicampania', 
				substring-after(url, 'http://anagrafebiblioteche.regione.campania.it'))"/>
				</url>
				<xsl:copy-of select="didascalia"/>
			</xsl:if>
			</immagine>
		</xsl:for-each>
		</immagini>
	</xsl:template>

</xsl:stylesheet>
