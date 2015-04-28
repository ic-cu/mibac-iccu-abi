<?xml version="1.0" ?>
<xsl:stylesheet version="1.0"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:import href="consistenza.xsl" />
	
	  <!-- il posseduto di ogni materiale è ignorato se "" (sempre con string-length) 
  c'é da verificare se un materiali vuoto cancella tutto il precedente-->

	<xsl:output method="xml" indent="yes" />

	<!-- patrimonio, solo se esiste (ma purtroppo a volte è vuoto) -->
	
	<xsl:template name="patrimonio">
		<xsl:element name="patrimonio">
			<xsl:apply-templates select='CONSISTENZA' />
			<xsl:if test="FONDISPEC">
				<xsl:call-template name="FONDISPEC" />
			</xsl:if>
			<xsl:apply-templates select='CONSISTENZA/TOTCONS' />
		</xsl:element>
	</xsl:template>

	<!-- fondi speciali, solo se esistono -->

	<xsl:template name="FONDISPEC">
		<xsl:element name="fondi-speciali">
			<xsl:for-each select='FONDISPEC'>
				<fondo-speciale>
					<nome>
						<xsl:value-of select="DENOMINAZIONE" />
					</nome>
					<descrizione>
						<xsl:value-of select="DESCRIZIONE" />
					</descrizione>
				</fondo-speciale>
			</xsl:for-each>
		</xsl:element>
	</xsl:template>
	
	
	<!--
		il totale-posseduto non viene creato se il sorgente è vuoto, come purtroppo abbiamo
		verificato; il trucco è string-length
	-->
	<xsl:template match="//scheda_BIBLIO/CONSISTENZA/TOTCONS">
		<xsl:if test="not(string-length()=0)">
			<xsl:element name="totale-posseduto">
				<xsl:value-of select="." />
			</xsl:element>
		</xsl:if>
	</xsl:template>
		
	<!-- spesso descrizioni vuote, testare anche qui con string-length? -->
	<xsl:template match="//scheda_BIBLIO/FONDISPEC">
		<xsl:element name="fondo-speciale">
			<xsl:element name="nome">
				<xsl:value-of select="DENOMINAZIONE" />
			</xsl:element>
			<xsl:element name="descrizione">
				<xsl:value-of select="DESCRIZIONE" />
			</xsl:element>
		</xsl:element>
	</xsl:template>
	
</xsl:stylesheet>