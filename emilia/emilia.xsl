<?xml version="1.0"?>
<xsl:stylesheet 
xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:xalan="http://xml.apache.org/xslt" version="1.0">

	<!--
		Foglio di stile per correggere piccoli difetti di un file 1.6 derivato
		da un export dell'Emilia-Romagna. Importa il generico convert con
		l'aggiunta di template per qualche elemento da trattare in modo diverso
		rispetto a quanto avviene in convert
	-->

	<xsl:import href="../convert/main.xsl" />
	<xsl:import href="cataloghi.xsl" />	
	<xsl:import href="patrimonio.xsl" />
	<xsl:import href="mappa.xsl" />
	<xsl:output method="xml" indent="yes" encoding="UTF-8" xalan:indent-amount="2"/>
	

</xsl:stylesheet>
