<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	version="1.0">

<!--
	Foglio di stile per correggere piccoli difetti di un file 1.6 inviato
	dalla Regione Veneto. È sostanzialmente un "copy with recursion" con
	l'aggiunta di template per i vari elementi da correggere
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

	<xsl:template match="//biblioteca/anagrafica">
		<xsl:element name="anagrafica">
			<xsl:copy-of select="data-censimento"/>
			<xsl:copy-of select="data-aggiornamento"/>

<!-- si inserisce il nuovo elemento fonte e si copia tutto il resto -->

			<xsl:element name="fonte">
				<xsl:element name="descrizione">Regione del Veneto - Direzione
				Beni Culturali (aggiornamento: anagrafiche all’11.12.2013,
				patrimonio e servizi al 31.12.2012)</xsl:element>
				<xsl:element
				name="url">http://bibliotecheweb.regione.veneto.it/BibliotecheWeb/</xsl:element>
			</xsl:element>
			<xsl:copy-of select="nomi"/>
			<xsl:copy-of select="codici"/>
			<xsl:copy-of select="indirizzo"/>

<!-- 
	I contatti si trattano a parte.	C'è una notevole differenza fra "//contatti" e
	"contatti": il primo caso va a pescare tutti i "contatti" ovunque, il secondo
	solo nell'elemento corrente. Il resto degli elementi anagrafici si copia.
-->

			<xsl:apply-templates select="contatti"/>
			<xsl:copy-of select="edificio"/>
			<xsl:copy-of select="istituzione"/>
		</xsl:element>
	</xsl:template>

<!-- 
	Soppressione dei contatti tipo URL con valore=NO. Prima serve un template che
	copi i "telefonici" e invochi un altro template per gli "altri". Anche qui
	bisogna fare attenzione a invocare i template senza i "//" iniziali.
-->

	<xsl:template match="//contatti">
		<xsl:element name="contatti">
			<xsl:copy-of select="telefonici"/>
			<xsl:apply-templates select="altri"/>
		</xsl:element>
	</xsl:template>

	<xsl:template match="//contatti/altri">
		<xsl:if test="altro">
			<xsl:element name="altri">
				<xsl:for-each select="altro">
					<xsl:if test="not(@tipo = 'url' and valore = 'NO')">
						<xsl:copy-of select="."/>
					</xsl:if>
				</xsl:for-each>
			</xsl:element>
		</xsl:if>
	</xsl:template>

<!--
	Certi materiali vanno mappati opportunamente. Notare che è necessario
	un xsl:choose, altrimenti solo i casi positivi passano, i negativi no,
	anche se sono proprio gli unici sicuramente corretti
-->
	<xsl:template match="//ZZmateriali/materiale">
		<xsl:choose>
		<xsl:when test="contains(@nome,'CARTOGRAFIA A STAMPA')">
			<xsl:element name="materiale">
				<xsl:attribute name="nome">carte geografiche e mappe</xsl:attribute>
				<xsl:copy-of select="*" />
			</xsl:element>
		</xsl:when>

<!-- questo è l'unico modo per testare stringhe con apostrofo -->

		<xsl:when test="contains(@nome,concat('DOCUMENTI D', &quot;'&quot;,
		'ARCHIVIO'))">
			<xsl:element name="materiale">
				<xsl:attribute name="nome">documenti archivistici a stampa</xsl:attribute>
				<xsl:copy-of select="*" />
			</xsl:element>
		</xsl:when>

		<xsl:when test="contains(@nome,'EDIZIONI DEL CINQUECENTO')">
			<xsl:element name="materiale">
				<xsl:attribute name="nome">edizioni del '500</xsl:attribute>
				<xsl:copy-of select="*" />
			</xsl:element>
		</xsl:when>

		<xsl:when test="contains(@nome,'EDIZIONI DEL SEICENTO')">
			<xsl:element name="materiale">
				<xsl:attribute name="nome">edizioni del '600</xsl:attribute>
				<xsl:copy-of select="*" />
			</xsl:element>
		</xsl:when>

		<xsl:when test="contains(@nome,'EDIZIONI DEL SETTECENTO')">
			<xsl:element name="materiale">
				<xsl:attribute name="nome">edizioni del '700</xsl:attribute>
				<xsl:copy-of select="*" />
			</xsl:element>
		</xsl:when>

<!-- ancora un test di stringa con apostrofo -->

		<xsl:when test="contains(@nome,concat('EDIZIONI DELL', &quot;'&quot;, 'OTTOCENTO'))">
			<xsl:element name="materiale">
				<xsl:attribute name="nome">edizioni del '800</xsl:attribute>
				<xsl:copy-of select="*" />
			</xsl:element>
		</xsl:when>

		<xsl:when test="contains(@nome,'EPISTOLARI E CARTEGGI')">
			<xsl:element name="materiale">
				<xsl:attribute name="nome">carteggi</xsl:attribute>
				<xsl:copy-of select="*" />
			</xsl:element>
		</xsl:when>

		<xsl:when test="contains(@nome,'FONDI ANTICHI - CARTE GEOGRAFICHE MANOSCRITTE')">
			<xsl:element name="materiale">
				<xsl:attribute name="nome">carte geografiche</xsl:attribute>
				<xsl:copy-of select="*" />
			</xsl:element>
		</xsl:when>

		<xsl:when test="contains(@nome,'FONDI ANTICHI - MUSICA MANOSCRITTA')">
			<xsl:element name="materiale">
				<xsl:attribute name="nome">musica manoscritta</xsl:attribute>
				<xsl:copy-of select="*" />
			</xsl:element>
		</xsl:when>

		<xsl:when test="contains(@nome,'FONDI ANTICHI - MANOSCRITTI')">
			<xsl:element name="materiale">
				<xsl:attribute name="nome">manoscritti</xsl:attribute>
				<xsl:copy-of select="*" />
			</xsl:element>
		</xsl:when>

<!-- in questo caso si presuppone che la biblioteca disponga sia di
incisioni che di stampe, e quindi si creano due elementi -->

		<xsl:when test="contains(@nome,'INCISIONI E STAMPE')">
			<xsl:element name="materiale">
				<xsl:attribute name="nome">incisioni</xsl:attribute>
				<xsl:copy-of select="*" />
			</xsl:element>
			<xsl:element name="materiale">
				<xsl:attribute name="nome">stampe</xsl:attribute>
				<xsl:copy-of select="*" />
			</xsl:element>
		</xsl:when>

		<xsl:when test="contains(@nome,'MATERIALE GRAFICO (FONDI FOTOGRAFICI, CARTOLINE, MANIFESTI)')">
			<xsl:element name="materiale">
				<xsl:attribute name="nome">materiale grafico</xsl:attribute>
				<xsl:copy-of select="*" />
			</xsl:element>
		</xsl:when>

		<xsl:when test="contains(@nome,'MUSICA A STAMPA')">
			<xsl:element name="materiale">
				<xsl:attribute name="nome">documenti musicali a stampa</xsl:attribute>
				<xsl:copy-of select="*" />
			</xsl:element>
		</xsl:when>

<!-- se nessuno dei test è positivo, il materiale va copiato senza
alterazioni, altrimenti non andrebbe in output -->

		<xsl:otherwise>
			<xsl:copy-of select="." />
		</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

<!-- per dire che una biblioteca è aperta o riservata va usato
l'elemento apposito, non una modalità di accesso -->

	<xsl:template match="//ZZaccesso">
			<xsl:element name="accesso">
		<xsl:if test="contains(modalita-accesso/modo,'APERT')">
			<xsl:element name="aperta">s</xsl:element>
		</xsl:if>
		<xsl:if test="contains(modalita-accesso/modo,'RISERVAT')">
			<xsl:element name="aperta">n</xsl:element>
		</xsl:if>
			</xsl:element>
	</xsl:template>

<!-- c'è un sistema errato solo a causa di un doppio blank -->

	<xsl:template match="//sistemi/sistema">
		<xsl:choose>
		<xsl:when test="contains(.,'POLO  BIBLIOTECARIO DI CASTELFRANCO VENETO')">
		<xsl:element name="sistema">POLO BIBLIOTECARIO DI CASTELFRANCO VENETO</xsl:element>
		</xsl:when>
		<xsl:when test="contains(.,'ZZZPD3')">
		<xsl:element name="sistema">CENTRO SERVIZI BIBLIOTECHE PROVINCIALE DI PADOVA, PD3</xsl:element>
		</xsl:when>
		<xsl:otherwise>
				<xsl:copy-of select="." />
		</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

</xsl:stylesheet>
