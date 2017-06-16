<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	version="1.0">

<!--
	Foglio di stile per correggere o mappare alcune voci di autorità relative a
	tipologie amministrative e funzionali
-->

	<xsl:output method="xml" indent="yes" encoding="UTF-8" />

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
		
	   <xsl:when test=". = 'Direzione generale per i beni archeologici'">
		<xsl:element name="tipologia-amministrativa">Direzione generale archeologia, belle arti e paesaggio</xsl:element>
		</xsl:when>
		   <xsl:when test=". = 'Direzione generale per gli archivi'">
		<xsl:element name="tipologia-amministrativa">Direzione Generale Archivi</xsl:element>
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

</xsl:stylesheet>
