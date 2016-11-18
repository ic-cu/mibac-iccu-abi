<?xml version="1.0" ?>
<xsl:stylesheet
	version="1.0"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
>

	<xsl:output
		method="xml"
		indent="yes"/>

	<xsl:template name="anagrafica">
		<anagrafica>
			<fonte>
				<descrizione>Regione Umbria</descrizione>
				<url>http://opacsbn.regioneumbria.eu/SebinaOpac/Opac</url>
			</fonte>
			<nomi>
				<attuale>
					<xsl:value-of select="SP/SPC/SPCD"/>
				</attuale>
			</nomi>
			<codici>
				<isil>IT-AA0000</isil>
				<sbn>
					<xsl:value-of select="CD/NCT/NCTA"/>
				</sbn>
			</codici>
			<indirizzo>
				<via>
					<xsl:value-of select="PV/PVC/PVCI"/>
				</via>
				<cap>
					<xsl:value-of select="PV/PVC/PVCV"/>
				</cap>
				<xsl:if test="PV/PVC/PVCL">
					<frazione>
						<xsl:value-of select="PV/PVC/PVCL"/>
					</frazione>
				</xsl:if>
				<xsl:apply-templates select="PV/PVC/PVCC"/>
				<xsl:if test="PV/PVC/PVCG">
					<coordinate>
						<xsl:attribute name="latitudine">
					<xsl:value-of select="substring-before(PV/PVC/PVCG, ',')"/>
				</xsl:attribute>
						<xsl:attribute name="longitudine">
					<xsl:value-of select="substring-before(substring-after(PV/PVC/PVCG, ','), ',')"/>
				</xsl:attribute>
					</coordinate>
				</xsl:if>
			</indirizzo>
			<contatti>
				<xsl:if test="SP/SPC/SPCN|SP/SPC/SPCF">
					<telefonici>
						<xsl:for-each select="SP/SPC/SPCN">
							<telefonico tipo="telefono">
								<prefisso>+39</prefisso>
								<numero>
									<xsl:value-of select="."/>
								</numero>
							</telefonico>
						</xsl:for-each>
						<xsl:for-each select="SP/SPC/SPCF">
							<telefonico tipo="fax">
								<prefisso>+39</prefisso>
								<numero>
									<xsl:value-of select="."/>
								</numero>
							</telefonico>
						</xsl:for-each>
					</telefonici>
				</xsl:if>
				<xsl:if test="SP/SPC/SPCE|SP/SPC/SPCW">
					<altri>
						<xsl:for-each select="SP/SPC/SPCE">
							<altro tipo="e-mail">
								<valore>
									<xsl:value-of select="."/>
								</valore>
							</altro>
						</xsl:for-each>
						<xsl:for-each select="SP/SPC/SPCW">
							<altro tipo="url">
								<valore>
									<xsl:value-of select="."/>
								</valore>
							</altro>
						</xsl:for-each>
					</altri>
				</xsl:if>
			</contatti>
		</anagrafica>
	</xsl:template>
</xsl:stylesheet>