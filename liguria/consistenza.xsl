<?xml version="1.0" ?>
<xsl:stylesheet version="1.0"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:import href="mappa.xsl" />
	<xsl:output method="xml" indent="yes" />

	<xsl:template match="//scheda_BIBLIO/CONSISTENZA">
		<materiali>

			<!-- Se queste sono tutte biblioteche con totcons significativo, diamo 
				per scontato che abbiano volumi e opuscoli, ma evitiamo la quantificazione 
				perché a questo punto ancora non sappiamo come quantificare. Se più avanti 
				si trovassero "Edizioni XX/XXI adulti", verrebbe creato un secondo "volumi 
				e opuscoli" quantificato che, in import, sovrascriverebbe questo qui sotto. -->
			<materiale nome="volumi ed opuscoli" />

			<!-- questo test dovrebbe condizionare l'elemento contenitore, piuttosto 
				che i contenuti: se non c'è DETTAGLIO né PERIODICI è inutile creare il contenitore; 
				per adesso il test si limita a non creare elementi "materiale" -->

			<xsl:if test="CATEGORIA/DETTAGLIO">
				<xsl:for-each select="CATEGORIA/DETTAGLIO">

					<!-- per ogni DETTAGLIO trovato mette via la quantità, poi mette in 
						una variabile $n (per "nome") il risultato della mappatura, se questa è possibile -->

					<xsl:variable name="q">
						<xsl:value-of select="@quantita" />
					</xsl:variable>
					<xsl:variable name="n">
						<xsl:call-template name="mappa">
							<xsl:with-param name="d">
								<xsl:value-of select="@descrizione" />
							</xsl:with-param>
						</xsl:call-template>
					</xsl:variable>
					<materiale nome="{$n}">
						<xsl:if test="not(string-length($q)=0) and not($q = 0)">
							<xsl:attribute name="posseduto"><xsl:value-of
								select="$q" /></xsl:attribute>
						</xsl:if>
					</materiale>
				</xsl:for-each>
			</xsl:if>

			<!-- I periodici sono quantificati fuori dalla consistenza, ma per noi 
				sono un materiale e quindi si cerca di includerli qui. Da notare che, per 
				evitare periodici=0, il valore da usare nel test dev'essere numerico, non 
				stringa (cioè non '0', ma solo 0). -->
			<xsl:variable name="p">
				<xsl:value-of select="normalize-space(../PERIODICI)" />
			</xsl:variable>
			<xsl:if test="not($p = '') and not($p = 0)">
				<xsl:element name="materiale">
					<xsl:attribute name="nome">periodici</xsl:attribute>
					<xsl:attribute name="posseduto">
						<xsl:value-of select="$p" />
					</xsl:attribute>
				</xsl:element>
			</xsl:if>
		</materiali>
	</xsl:template>

	<!-- il totale-posseduto non viene creato se il sorgente è vuoto, come purtroppo 
		abbiamo verificato; il trucco è string-length -->

	<xsl:template match="//scheda_BIBLIO/CONSISTENZA/TOTCONS">
		<xsl:if test="not(string-length()=0)">
			<xsl:element name="totale-posseduto">
				<xsl:value-of select="." />
			</xsl:element>
		</xsl:if>
	</xsl:template>

</xsl:stylesheet>