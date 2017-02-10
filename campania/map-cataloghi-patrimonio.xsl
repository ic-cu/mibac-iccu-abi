<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	version="1.0">

<!--
	Foglio di stile per correggere o mappare alcune voci di autorità relative a
	cataloghi e patrimonio
-->

	<xsl:output method="xml" indent="yes" encoding="UTF-8" />

<!-- cataloghi collettivi, solo uno è da correggere -->

	<xsl:template match="//catalogo-collettivo/nome">
		<xsl:choose>
		<xsl:when test="contains(.,'Sistema bibliotecario di Ateneo. Università degli Studi di Napoli Federico 2°')">
		<xsl:element name="nome">Sistema bibliotecario di Ateneo. Università degli Studi di Napoli Federico II</xsl:element>
		</xsl:when>
		<xsl:when test="contains(.,'Catalogo delle biblioteche dell’INAF')">
		<nome>Catalogo collettivo delle biblioteche dell'Istituto Nazionale di Astrofisica - INAF</nome>
		</xsl:when>
		<xsl:when test="contains(., 'Sistema bibliotecario d') and contains(., 'Ateneo. Università degli Studi di Salerno')">
		<xsl:element name="nome">Catalogo collettivo dell'Università degli studi di Salerno</xsl:element>
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
		<xsl:when test="contains(.,'libri elettronici')">
		<xsl:attribute name="nome">documenti elettronici</xsl:attribute>
		</xsl:when>
		<xsl:when test=". = 'musica'">
		<xsl:attribute name="nome">documenti musicali a stampa</xsl:attribute>
		</xsl:when>
				
		<xsl:otherwise>
				<xsl:copy-of select="." />
		</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet>
