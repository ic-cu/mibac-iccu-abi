<?xml version="1.0" ?>
<xsl:stylesheet version="1.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="xml" indent="yes" />

	<!-- qualcosa nei servizi, poco più di orario, il resto è difficile da usare -->
	<xsl:template name="servizi">
		<xsl:element name="servizi">
			<xsl:element name="orario">
				<!-- le due righe sono necessarie perché l'orario ufficiale deve precedere le
					variazioni (si assume che "invernale" significhi "ufficiale" -->
        <xsl:apply-templates select="APERTURA/ORARIO[contains(@descrizione, 'nvernale')]" />
				<xsl:apply-templates select="APERTURA/ORARIO[contains(@descrizione,'stivo')]" />
				<xsl:apply-templates select="APERTURA/CHIUSURA" />
			</xsl:element>
			<xsl:apply-templates select="SERVIZI/SERVIZIO[contains(., 'utomatizzato')]"/>
			<!-- questa è stata una fatica: invoca il template solo se l'elemento SERVIZIO
				contiene la stringa 'nformazion' (pare non funzionino "espressioni regolari", quindi
				'nformazion' è il massimo che si possa fare) -->
			<xsl:apply-templates select="SERVIZI/SERVIZIO[contains(., 'nformazion')]" />
			<xsl:element name="internet">
				<xsl:attribute name="attivo">s</xsl:attribute>
			</xsl:element>
			<xsl:if test="starts-with(APERTURA/CONDIZIONI, 'Aperta a Tutti')">
				<accesso>
					<aperta>s</aperta>
				</accesso> 
			</xsl:if>
		</xsl:element>
	</xsl:template>
	<!--
		qui il problema è ottenere per primo l'orario ufficiale, come previsto
		dal formato ICCU; è stato risolto invocando due volte il template con @descrizione
		diverse, vedi sopra
	-->
	<xsl:template match="//scheda_BIBLIO/APERTURA/ORARIO">
		<xsl:if test="contains(@descrizione, 'nvernale')">
			<xsl:element name="ufficiale">
				<xsl:apply-templates select="GIORNO" />
			</xsl:element>
		</xsl:if>
		<xsl:if test="contains(@descrizione, 'stivo')">
			<xsl:element name="variazione">
				<xsl:apply-templates select="GIORNO" />
				<xsl:element name="note">
					<xsl:value-of select="@descrizione" />
				</xsl:element>
			</xsl:element>
		</xsl:if>
	</xsl:template>
	<!--
		qui la cosa più difficile è riportare i nomi dei giorni alle
		abbreviazioni usate nel formato ICCU: la tecnica usata consiste nel
		prendere le prime tre lettere e, in mancanza di una funzione
		"lower-case" introdotta solo in XPath 2.0, tradurre le sei possibili
		lettere maiuscole nelle rispettive minuscole;
		il template va applicato solo dall'interno di un elemento
		"orario/ufficiale" oppure "orario/variazione" dell'output
	-->
	<xsl:template match="//scheda_BIBLIO/APERTURA/ORARIO/GIORNO">
		<xsl:element name="orario">
			<xsl:attribute name="giorno">
				<xsl:value-of select="translate(substring(@nome,1,3), 'LMGVSD', 'lmgvsd')" />
			</xsl:attribute>
			<xsl:attribute name="dalle"><xsl:value-of select="FASCIA/@dalle" /></xsl:attribute>
			<xsl:attribute name="alle"><xsl:value-of select="FASCIA/@alle" /></xsl:attribute>
		</xsl:element>
	</xsl:template>
	
	<xsl:template match="//scheda_BIBLIO/APERTURA/CHIUSURA">
		<xsl:element name="chiusura">
			<!-- <xsl:element name="note"> -->
			<note>
				<xsl:value-of select="normalize-space(.)" />
			</note>
			<!-- </xsl:element> -->
		</xsl:element>
	</xsl:template>
	
	<xsl:template match="//scheda_BIBLIO/SERVIZI/SERVIZIO">
		<xsl:if test="contains(., 'nformazion')">
			<informazioni-bibliografiche>
				<xsl:attribute name="attivo">s</xsl:attribute>
				<servizio-interno>s</servizio-interno>
			</informazioni-bibliografiche>
		</xsl:if>
		<xsl:if test="contains(., 'utomatizzato')">
			<prestito>
				<locale>
					<xsl:attribute name="attivo">s</xsl:attribute>
					<automatizzato>s</automatizzato>
				</locale>
			</prestito>
		</xsl:if>
	</xsl:template>
	
</xsl:stylesheet>