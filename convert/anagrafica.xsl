<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

	<!-- Foglio di stile per la conversione di file 1.5 a file 1.6 -->

	<xsl:output method="xml" indent="yes" encoding="UTF-8" />

	<!-- Template per l'elemento root che si limita ad impostare il namespace 
		del formato di scambio per poi invocare i template disponibili -->

	<xsl:template match="/biblioteche">
		<xsl:copy>
			<xsl:attribute name="xsi:noNamespaceSchemaLocation">http://anagrafe.iccu.sbn.it/opencms/opencms/informazioni/formato-di-scambio/biblioteca-1.6.xsd</xsl:attribute>
			<xsl:apply-templates />
		</xsl:copy>
	</xsl:template>

	<!-- Converte dataExport in data-export eventualmente assegnando un valore 
		per difetto se assente in input un dataExport -->

	<xsl:template match="//dataExport">
		<xsl:if test=".">
			<data-export>
				<xsl:value-of select="." />
			</data-export>
		</xsl:if>
		<xsl:if test="not(.)">
			<data-export>2000-12-31T00:00:00.000+01:00</data-export>
		</xsl:if>
	</xsl:template>

	<!-- Anagrafica: oltre a invocare diversi template, corregge i nomi di alcune 
		date, eventualmente valorizzando la data-aggiornamento se assente, e copiando 
		gli indirizzi che non richiedono trattamenti -->

	<xsl:template match="//anagrafica/dataCensimento">
		<data-censimento>
			<xsl:apply-templates select="node()|@*" />
		</data-censimento>
	</xsl:template>

	<xsl:template match="//anagrafica/dataAggiornamento">
		<xsl:if test=".">
			<data-aggiornamento>
				<xsl:value-of select="." />
				<xsl:if test="@tipo">
					<xsl:attribute name="tipo">
					<xsl:value-of select="@tipo" />
				</xsl:attribute>
				</xsl:if>
			</data-aggiornamento>
		</xsl:if>
		<xsl:if test="not(.)">
			<data-aggiornamento>2000-12-31T00:00:00.000+01:00</data-aggiornamento>
		</xsl:if>
	</xsl:template>

	<!-- I nomi ora vanno in appositi contenitori -->

	<xsl:template match="//anagrafica/nome">
		<nomi>
			<xsl:copy-of select="attuale" />
			<xsl:if test="precedente">
				<precedenti>
					<xsl:for-each select="precedente">
						<xsl:copy-of select="." />
					</xsl:for-each>
				</precedenti>
			</xsl:if>
			<xsl:if test="alternativo">
				<alternativi>
					<xsl:for-each select="alternativo">
						<xsl:copy-of select="." />
					</xsl:for-each>
				</alternativi>
			</xsl:if>
		</nomi>
	</xsl:template>

	<!-- Contenitori anche per i contatti -->

	<xsl:template match="//contatti">
		<contatti>
			<xsl:if test="telefonico">
				<telefonici>
					<xsl:for-each select="telefonico">
						<xsl:copy-of select="." />
					</xsl:for-each>
				</telefonici>
			</xsl:if>
			<xsl:if test="altro">
				<altri>
					<xsl:for-each select="altro">
						<xsl:copy-of select="." />
					</xsl:for-each>
				</altri>
			</xsl:if>
		</contatti>
	</xsl:template>

	<!-- In edificio vanno corretti alcuni nomi -->

	<xsl:template match="//edificio/appositamenteCostruito">
		<xsl:if test=".">
			<appositamente-costruito>
				<xsl:value-of select="." />
			</appositamente-costruito>
		</xsl:if>
	</xsl:template>

	<!-- Sempre in edificio, viene gestita la data di costruzione, copiando 
		anche l'attributo "tipo" per distinguere anni e secoli. Dev'esserci un modo 
		più semplice di farlo -->

	<xsl:template match="//edificio/dataCostruzione">
		<data-costruzione>
			<xsl:if test="@tipo">
				<xsl:attribute name="tipo">
					<xsl:value-of select="@tipo" />
				</xsl:attribute>
			</xsl:if>
			<xsl:value-of select="." />
		</data-costruzione>
	</xsl:template>

	<!-- Converte nomi in Istituzone, cominciando proprio con questo elemento. 
		Gestisce anche gli attributi "tipo" delle date, per distinguere anni e secoli -->

	<xsl:template match="//Istituzione">
		<istituzione>
			<xsl:apply-templates />
		</istituzione>
	</xsl:template>

	<xsl:template match="//Istituzione/dataIstituzione">
		<data-istituzione>
			<xsl:if test="@tipo">
				<xsl:attribute name="tipo">
					<xsl:value-of select="@tipo" />
				</xsl:attribute>
			</xsl:if>
			<xsl:value-of select="." />
		</data-istituzione>
	</xsl:template>

	<xsl:template match="//Istituzione/dataFondazione">
		<data-fondazione>
			<xsl:if test="@tipo">
				<xsl:attribute name="tipo">
					<xsl:value-of select="@tipo" />
				</xsl:attribute>
			</xsl:if>
			<xsl:value-of select="." />
		</data-fondazione>
	</xsl:template>

	<!-- Corregge il nome del codice ISIL e anche il suo valorei, ma solo se 
		manca l'IT- e non è lungo 6 -->

	<xsl:template match="//codici/iccu">
		<xsl:if test="not(string-length(.) = 9)">
			<xsl:comment>
				*** CODICE ISIL ERRATO ***
			</xsl:comment>
		</xsl:if>
		<isil>
			<xsl:if test="not(starts-with(., 'IT-'))">
				<xsl:value-of select="concat('IT-', iccu)" />
			</xsl:if>
			<xsl:if test="starts-with(., 'IT-')">
				<xsl:value-of select="." />
			</xsl:if>
		</isil>
	</xsl:template>
</xsl:stylesheet>
