<?xml version="1.0"?>
<xsl:stylesheet 
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns:xalan="http://xml.apache.org/xslt" version="1.0">

<!--
conversione da versione 1.4 e 1.5 a versione 1.6
-->

	<xsl:import href="identity.xsl" />
	<xsl:import href="anagrafica.xsl" />
	<xsl:import href="cataloghi.xsl" />
	<xsl:import href="patrimonio.xsl" />
	<xsl:import href="servizi.xsl" />
	<xsl:output method="xml" indent="yes" encoding="UTF-8" xalan:indent-amount="2"/>
  <xsl:template match="//funzione-obiettivo"/>
  <xsl:template match="//part-time[normalize-space()='']"/>

</xsl:stylesheet>
