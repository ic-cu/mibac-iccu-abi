<?xml version="1.0" ?>
<xsl:stylesheet version="1.0"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <!-- il posseduto di ogni materiale è ignorato se "" (sempre con string-length) 
  c'é da verificare se un materiali vuoto cancella tutto il precedente-->

	<xsl:import href="comune.xsl" />

	<xsl:output method="xml" indent="yes" />

	<xsl:template match="//scheda_BIBLIO/RECAPITI">
		<xsl:element name="indirizzo">
			<xsl:element name="via">
				<xsl:value-of select="INDIRIZZO" />
			</xsl:element>
			<xsl:element name="cap">
				<xsl:value-of select="CAP" />
			</xsl:element>
			<xsl:apply-templates select="COMUNE" />
			<!--
				metteremo in altro template <xsl:element name="comune"> <xsl:value-of
				select="COMUNE"/> </xsl:element> <xsl:element name="provincia">
				<xsl:value-of select="PROVINCIA"/> </xsl:element>
			-->
		</xsl:element>
		<!-- il comune,ora obbligatorio andrà mappato con la tabella ISTAT -->
		<xsl:element name="contatti">
			<!-- il prefisso è obbligatorio, ma è sempre +39 -->
			<xsl:element name="telefonici">
				<xsl:element name="telefonico">
					<xsl:attribute name="tipo">telefono</xsl:attribute>
					<prefisso>+39</prefisso>
					<numero><xsl:value-of select="TELEFONO" /></numero>
				</xsl:element>
				<xsl:element name="telefonico">
					<xsl:attribute name="tipo">fax</xsl:attribute>
					<prefisso>+39</prefisso>
					<numero><xsl:value-of select="FAX" /></numero>
				</xsl:element>
			</xsl:element>
			
			<xsl:if test="not(normalize-space(E_MAIL)) = '' or not(normalize-space(HOMEPAGE)) = '' or not(normalize-space(PEC)) = ''">
			
			<altri>
				<xsl:if test="not(normalize-space(E_MAIL)) = ''">
					<altro tipo="e-mail">
						<valore>
							<xsl:value-of select="E_MAIL" />
						</valore>
					</altro>
				</xsl:if>
				<xsl:if test="not(normalize-space(HOMEPAGE)) = ''">
					<altro tipo="url">
						<valore>
							<xsl:value-of select="HOMEPAGE" />
						</valore>
					</altro>
				</xsl:if>
				<xsl:if test="not(normalize-space(PEC)) = ''">
					<altro tipo="url">
						<valore>
							<xsl:value-of select="PEC" />
						</valore>
					</altro>
				</xsl:if>
			 </altri>
			</xsl:if>
		</xsl:element>
	</xsl:template>
	
	<xsl:template match="//scheda_BIBLIO/RECAPITI/HOMEPAGE">
		<xsl:element name="altro">
			<xsl:attribute name="tipo">url</xsl:attribute>
			<xsl:element name="valore">
				<xsl:value-of select="." />
			</xsl:element>
		</xsl:element>
	</xsl:template>
	
</xsl:stylesheet>