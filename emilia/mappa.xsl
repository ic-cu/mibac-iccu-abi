<?xml version="1.0"?>
<xsl:stylesheet
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	version="1.0"
>

	<!--
		Foglio di stile per correggere o mappare alcune voci di autorità relative a
		tipologie amministrative e funzionali
	-->

	<xsl:output
		method="xml"
		indent="yes"
		encoding="UTF-8"/>

	<!-- correzioni alle tipologie amministrative -->

	<xsl:template match="//tipologia-amministrativa">
		<xsl:choose>

			<xsl:when test=". = 'Accademie, Associazioni, Fondazioni, Istituti, Società (privati)'">
				<tipologia-amministrativa>Accademie, associazioni, fondazioni, istituti, societa' (privati)</tipologia-amministrativa>
			</xsl:when>

			<xsl:when test=". = 'Consorzio e/o associazioni di regioni, province, comuni e comunità montane'">
				<tipologia-amministrativa>Consorzio e/o associazioni di regioni, provincie, comuni e comunità montane</tipologia-amministrativa>
			</xsl:when>

			<xsl:otherwise>
				<xsl:copy-of select="."/>
			</xsl:otherwise>

		</xsl:choose>
	</xsl:template>


	<!-- ulteriori correzioni alle modalità di accesso standard;
		per ora è inattivo, ma resta qui per referenze future perché
		questo è il modo giusto di "aggiungere" trasformazioni specifiche -->

	<xsl:template match="//condizioni-accesso/documenti/tipo[. = 'XXX']">
		<modo>YYY</modo>
	</xsl:template>

	<!--
		Nomi di materiali. Il trattamento di un attributo sembra diverso dal caso di
		un elemento, visto per le tipologie: sembra che non si debba usare xsl:attribute.
		Qui inoltre si gestisce l'eventuale asterisco finale.
	-->

	<xsl:template match="//patrimonio/materiale/@nome">
		<xsl:choose>

			<xsl:when test="contains(., 'Volumi e opuscoli')">volumi ed opuscoli</xsl:when>

			<xsl:when test="contains(., 'Manoscritti musicali')">musica manoscritta</xsl:when>

			<xsl:when test="contains(.,'Collezioni digitalizzate')">IGNORARE: <xsl:value-of select="."/></xsl:when>

			<xsl:when test="contains(.,'Altri documenti di biblioteca')">IGNORARE: <xsl:value-of select="."/></xsl:when>

			<xsl:otherwise><xsl:if test="contains(., '*')"><xsl:value-of select="substring-before(.,'*')"/></xsl:if>
			<xsl:if test="not(contains(., '*'))"><xsl:value-of select="."/></xsl:if></xsl:otherwise>
			</xsl:choose>
	</xsl:template>

	<!--
		modalità e condizioni di accesso; il simbolo "<=" è un problema
	-->

	<xsl:template match="//modalita-accesso/modo">
		<xsl:choose>

			<xsl:when test="contains(.,' >= 15')">
				<xsl:element name="modo">
					Limite di eta': >= 15
				</xsl:element>
			</xsl:when>

			<xsl:when test="contains(.,' &lt;= 15')">
				<xsl:element name="modo">Limite
					di eta': &lt;= 15
				</xsl:element>
			</xsl:when>

			<xsl:otherwise>
				<xsl:copy-of select="."/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!-- alcuni nomi di cataloghi collettivi vanno corretti o tradotti -->

	<xsl:template match="//catalogo-collettivo/nome">
		<xsl:choose>

			<xsl:when test="contains(., 'Polo Unificato Ferrarese')">
				<nome>SBN - Polo Unificato Ferrarese</nome>
			</xsl:when>

			<xsl:when test="contains(., 'EDIT 16')">
				<nome>Censimento nazionale delle Edizioni italiane del XVI secolo</nome>
			</xsl:when>

			<xsl:when test="contains(., 'A-to-Z')">
				<nome>A-to-Z. Catalogo unico delle riviste elettroniche dell'Università di Ferrara</nome>
			</xsl:when>

			<xsl:when test="contains(., 'ACNP')">
				<nome>Archivio collettivo delle pubblicazioni periodiche</nome>
			</xsl:when>
			
			<xsl:when test="contains(., 'GDIF,RBM. Catalogo collettivo dei periodici delle biblioteche biomediche')">
				<nome>GIDIF,RBM. Catalogo collettivo dei periodici delle biblioteche biomediche</nome>
			</xsl:when>

			<xsl:when test="contains(., 'IBIS web')">
				<nome>IBISweb</nome>
			</xsl:when>
			
			<xsl:when test="contains(., 'IMAGO')">
				<nome>Imago - Catalogo regionale di opere grafiche e cartografiche</nome>
			</xsl:when>
			
			<xsl:when test="contains(., 'SBN-Polo Unificato Ferrarese')">
				<nome>SBN - Polo Unificato Ferrarese</nome>
			</xsl:when>

			<xsl:otherwise>
			<nome>
				<xsl:apply-templates select="node()"/></nome>
			</xsl:otherwise>

		</xsl:choose>
	</xsl:template>
	
<!-- 
Eventuali cataloghi inviati senza neanche il tipo vanno scartati, salvo che la 
Emilia-Romagna non spieghi il significato di questi casi.
 -->

	<xsl:template match="//catalogo-generale[not(@tipo)]"/>

<!-- 
ILL SBN viene indicato in molti modi in input, per cui va corretto almeno
nei casi più plausibili
 -->

	<xsl:template match="//sistema-ill/nome">
		<xsl:if test="contains(., 'SBN') or contains(., 'sbn')">
			<nome>ILL SBN</nome>
		</xsl:if>
		<xsl:if test="not(contains(., 'SBN') or contains(., 'sbn'))">
			<xsl:copy-of select="."/>
		</xsl:if>
	</xsl:template>

</xsl:stylesheet>