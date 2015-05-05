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
		</xsl:element>


<!-- 
I contatti vanno creati solo se almeno uno è significativo. Questo costringe a 
parecchi test sempre più fini, ma non c'era alternativa.
 -->
		<xsl:variable name="tel" select="normalize-space(TELEFONO)"/>
		<xsl:variable name="fax" select="normalize-space(FAX)"/>
		<xsl:variable name="email" select="normalize-space(E_MAIL)"/>
		<xsl:variable name="pec" select="normalize-space(PEC)"/>
		<xsl:variable name="url" select="normalize-space(HOMEPAGE)"/>

		<xsl:if test="$tel or $fax or $email or $pec or $url">
		<contatti>
			<!-- il prefisso è obbligatorio, ma è sempre +39 -->
		<xsl:if test="$tel or $fax">
			<telefonici>
				<xsl:if test="$tel">
				<telefonico tipo="telefono">
					<prefisso>+39</prefisso>
					<numero><xsl:value-of select="$tel" /></numero>
 				</telefonico>
				</xsl:if>
				<xsl:if test="$fax">
				<telefonico tipo="fax">
					<prefisso>+39</prefisso>
					<numero><xsl:value-of select="$fax" /></numero>
 				</telefonico>
				</xsl:if>
			</telefonici>
		</xsl:if>
			
			<xsl:if test="$email or $pec or $url">
	
			<altri>
				<xsl:if test="$email">
					<altro tipo="e-mail">
						<valore>
							<xsl:value-of select="$email" />
						</valore>
					</altro>
				</xsl:if>
				<xsl:if test="$url">
					<altro tipo="url">
						<valore>
							<xsl:value-of select="$url" />
						</valore>
					</altro>
				</xsl:if>
				<xsl:if test="$pec">
					<altro tipo="e-mail">
						<valore>
							<xsl:value-of select="$pec" />
						</valore>
					</altro>
				</xsl:if>
			 </altri>
			</xsl:if>
		</contatti>
		</xsl:if>
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