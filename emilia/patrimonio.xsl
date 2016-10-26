<?xml version="1.0"?>
<xsl:stylesheet
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	version="1.0"
>

	<!--
		Foglio di stile per la conversione di file 1.5 a file 1.6, relativamente
		al patrimonio e ai fondi speciali. Viene importato dal convertitore specifico
		per l'Emilia-Romagna
	-->

	<xsl:output
		method="xml"
		indent="yes"
		encoding="UTF-8"/>

	<!--
		Un template principale che ne richiama due, uno per i materiali, uno per i
		fondi speciali. La gestione degli asterischi è in un altro foglio, in un 
		template per le inevitabili mappature di nomi di materiali
	-->

	<xsl:template match="//biblioteca/patrimonio">
		<xsl:element name="patrimonio">
			<xsl:if test="materiale">
				<xsl:element name="materiali">
					<xsl:apply-templates select="materiale"/>
				</xsl:element>
			</xsl:if>
			<xsl:if test="fondo-speciale">
				<xsl:element name="fondi-speciali">
					<xsl:apply-templates select="fondo-speciale"/>
				</xsl:element>
			</xsl:if>
			<xsl:apply-templates select="fondi-antichi"/>
			<xsl:apply-templates select="inventario"/>
			<xsl:apply-templates select="catalogo-topografico"/>
			<xsl:apply-templates select="acquisti-ultimi-quindici-anni"/>
			<xsl:apply-templates select="totale-posseduto"/>
			<xsl:apply-templates select="totale-posseduto-ragazzi"/>
		</xsl:element>
	</xsl:template>

	<xsl:template match="//biblioteca/patrimonio/materiale">
		<xsl:element name="materiale">
			<xsl:attribute name="nome">
				<xsl:apply-templates select="@nome"/>
			</xsl:attribute>
			<xsl:apply-templates select="@posseduto"/>
			<xsl:apply-templates select="@acquisti-ultimo-anno"/>
		</xsl:element>
	</xsl:template>

	<xsl:template match="//biblioteca/patrimonio/fondo-speciale">
		<xsl:element name="fondo-speciale">
			<xsl:copy-of select="nome"/>
			<xsl:copy-of select="descrizione"/>

			<!--
				Qui si deve ricorrere a un trucco per scartare le eventuali CDD non puramente numeriche.
				Eventuali lettere nel valore sono trasformate tutte in 'A', e poi si controlla se il nuovo valore
				contiene 'A'. In questo caso non viene creato l'elemento. La soluzione è necessaria in XSLT 1.0,
				mentre in 2.0 si potrebbero usare espressioni regolari
			-->
			<xsl:variable
				name="alpha"
				select="'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZàèéìòù'"/>
			<xsl:variable
				name="subst"
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
						<xsl:when test="contains(cdd, '/')">
							<xsl:value-of select="substring-before(cdd, '/')"/>
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
	</xsl:template>
</xsl:stylesheet>
