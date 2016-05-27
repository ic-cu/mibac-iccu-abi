<?xml version="1.0"?>
<xsl:stylesheet 
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	version="1.0">

<!-- Foglio di stile per la conversione di file 1.5 a file 1.6 -->

	<xsl:output method="xml" indent="yes" encoding="UTF-8"/>

<!--
Patrimonio, basta un solo template, ma c'è da gestire gli asterischi
-->

	<xsl:template match="//biblioteca/patrimonio">
		<xsl:element name="patrimonio">
			<xsl:if test="materiale">
				<xsl:element name="materiali">
					<xsl:for-each select="materiale">
						<xsl:element name="materiale">
							<xsl:attribute name="nome">
							  <xsl:if test="not(contains(@nome, '*'))">
									<xsl:value-of select="@nome"/>
								</xsl:if>
							  <xsl:if test="contains(@nome, '*')">
									<xsl:copy-of select="substring-before(@nome,'*')"/>
								</xsl:if>
							</xsl:attribute>
							<xsl:copy-of select="@posseduto"/>
							<xsl:copy-of select="@acquisti-ultimo-anno"/>
						</xsl:element>
					</xsl:for-each>
				</xsl:element>
			</xsl:if>
			<xsl:if test="fondo-speciale">
				<xsl:element name="fondi-speciali">
					<xsl:for-each select="fondo-speciale">
						<xsl:element name="fondo-speciale">
							<xsl:copy-of select="nome"/>
							<xsl:copy-of select="descrizione"/>
							
<!--
Qui si deve ricorrere a un trucco per scartare le eventuali CDD non puramente numeriche.
Eventuali lettere nel valore sono trasformate tutte in 'A', e poi si controlla se il nuovo valore 
contiene 'A'. In questo caso non viene creato l'elemento. La soluzione è necessaria in XSLT 1.0,
mentre in 2.0 si potrebbero usare espressioni regolari 
 -->			
							<xsl:variable name="alpha" 
              select="'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZàèéìòù'"/>
							<xsl:variable name="subst" 
              select="'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA'"/>
							<xsl:if test="cdd[(string-length() != 0) and (not(contains(translate(., $alpha, $subst), 'A')))]">							
								<xsl:element name="cdd">
									<xsl:choose>
										<xsl:when test="contains(cdd, ',')">
											<xsl:value-of select="substring-before(cdd, ',')"/>
										</xsl:when>
										<xsl:when test="contains(cdd, ';')">
											<xsl:value-of select="substring-before(cdd, ';')"/>
										</xsl:when>
										<xsl:when test="contains(cdd, '-')">
											<xsl:value-of select="substring-before(cdd, '-')"/>
										</xsl:when>
										<xsl:otherwise>
											<xsl:value-of select="cdd"/>
										</xsl:otherwise>
									</xsl:choose>
								</xsl:element>
							</xsl:if>
							<xsl:copy-of select="depositato"/>
							<xsl:if test="catalogoInventario">
								<xsl:element name="catalogo-inventario">
									<xsl:value-of select="catalogoInventario"/>
								</xsl:element>
							</xsl:if>
							<xsl:if test="catalogoInventarioUrl">
								<xsl:element name="catalogo-inventario-url">
									<xsl:value-of select="catalogoInventarioUrl"/>
								</xsl:element>
							</xsl:if>
						</xsl:element>
					</xsl:for-each>
				</xsl:element>
			</xsl:if>
			<xsl:copy-of select="fondi-antichi"/>
			<xsl:copy-of select="inventario"/>
			<xsl:copy-of select="catalogo-topografico"/>
			<xsl:copy-of select="acquisti-ultimi-quindici-anni"/>
			<xsl:copy-of select="totale-posseduto"/>
			<xsl:copy-of select="totale-posseduto-ragazzi"/>
		</xsl:element>
	</xsl:template>
</xsl:stylesheet>
