<?xml version="1.0"?>
<xsl:stylesheet 
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	version="1.0">

<!-- Foglio di stile per la conversione di file 1.5 a file 1.6 -->

	<xsl:output method="xml" indent="yes" encoding="UTF-8"/>

<!--
Servizi, qui servono diversi template e va gestito l'attributo "attivo"
-->
  <xsl:template match="//servizi">
    <xsl:element name="servizi">
      <xsl:apply-templates select="orario"/>
      <xsl:apply-templates select="prestito"/>
      <xsl:if test="prestito/riproduzioni">
        <xsl:element name="riproduzioni">
          <xsl:attribute name="attivo">s</xsl:attribute>
          <xsl:for-each select="prestito/riproduzioni">
            <xsl:element name="riproduzione">
              <xsl:copy-of select="./*"/>
            </xsl:element>
          </xsl:for-each>
        </xsl:element>
      </xsl:if>
			<xsl:copy-of select="materiali-esclusi-locale"/>
      <xsl:if test="informazioni-bibliografiche">
        <xsl:element name="informazioni-bibliografiche">
          <xsl:attribute name="attivo">s</xsl:attribute>
          <xsl:copy-of select="informazioni-bibliografiche/*"/>
        </xsl:element>
      </xsl:if>

<!-- 
Gestione dell'accesso a internet. Si è passati ad una gestione più coerente,
per cui vanno valorizzati tre flag in base a valori opportuni dell'elemento
sorgente, che era una semplice stringa. Inoltre, se presente l'elemento, anche
vuoto, va valorizzato l'attributo "attivo"
-->
      <xsl:if test="internet">
        <xsl:element name="internet">
          <xsl:attribute name="attivo">s</xsl:attribute>
          <xsl:if test="internet/modo = 'limitato'">
						<xsl:element name="con-proxy">s</xsl:element>
          </xsl:if>
          <xsl:if test="internet/modo = 'Selezionato'">
						<xsl:element name="con-proxy">s</xsl:element>
          </xsl:if>
          <xsl:if test="internet/modo = 'libero'">
						<xsl:element name="con-proxy">n</xsl:element>
          </xsl:if>
          <xsl:if test="internet/modo = 'Libero'">
						<xsl:element name="con-proxy">n</xsl:element>
          </xsl:if>
          <xsl:if test="internet/modo = 'A pagamento'">
						<xsl:element name="a-pagamento">s</xsl:element>
          </xsl:if>
          <xsl:if test="internet/modo = 'A tempo'">
						<xsl:element name="a-tempo">s</xsl:element>
          </xsl:if>
        </xsl:element>
      </xsl:if>
      <xsl:apply-templates select="accesso"/>
      <xsl:call-template name="sistemi"/>
      <xsl:copy-of select="sezioni-speciali"/>
    </xsl:element>
  </xsl:template>

<!--
Gestisce anche i limiti di età, ora ridotti ad una stringa libera, 
controllata solo dai vocabolari. Notare che, siccome modalita-accesso
non può essere vuoto, viene controllato che condizioni-accesso non sia
vuoto.
-->
	<xsl:template match="accesso">
    <xsl:element name="accesso">
      <xsl:copy-of select="aperta"/>
      <xsl:copy-of select="handicap"/>
			<xsl:if test="condizioni-accesso/*">
				<xsl:element name="modalita-accesso">
					<xsl:for-each select="condizioni-accesso/documenti/tipo">
						<xsl:element name="modo">
						  <xsl:value-of select="."/>
						</xsl:element>
					</xsl:for-each>
					<xsl:for-each select="condizioni-accesso/eta[@min]">
						<xsl:element name="modo">
								<xsl:text>Limite di eta': &gt;= </xsl:text>
						  <xsl:value-of select="@min"/>
						</xsl:element>
					</xsl:for-each>
					<xsl:for-each select="condizioni-accesso/eta[@max]">
						<xsl:element name="modo">
								<xsl:text>Limite di eta': &lt;= </xsl:text>
						  <xsl:value-of select="@max"/>
						</xsl:element>
					</xsl:for-each>
					<xsl:if test="condizioni-accesso/appuntamento">
						<xsl:element name="modo">
						  <xsl:text>appuntamento</xsl:text>
						</xsl:element>
					</xsl:if>
				</xsl:element>
			</xsl:if>
    </xsl:element>
  </xsl:template>

<!--
Nella versione 1.5 i sistemi erano ancora ripetibili, ma non il loro
sottoelemento sistema. Ora invece, giustamente, è proprio il contrario,
quindi diversi elementi sistemi devono confluire in uno solo.
Il template va invocato, non applicato come di solito, perché altrimenti
pescherebbe ogni "sistemi" creando altrettanti elementi omonimi. Manca
ancora un test per essere sicuri che almeno un "sistemi" esista,
altrimenti ne viene creato uno vuoto.
-->
	<xsl:template name="sistemi">
	  <xsl:if test="sistemi">
			<xsl:element name="sistemi">
				<xsl:for-each select="sistemi/sistema">
					<xsl:copy-of select="."/>
				</xsl:for-each>
			</xsl:element>
		</xsl:if>
  </xsl:template>

  <!-- Prestito, qualche elemento contenitore -->

  <xsl:template match="//prestito">
    <xsl:element name="prestito">
      <xsl:if test="locale">
        <xsl:element name="locale">
          <xsl:attribute name="attivo">s</xsl:attribute>
          <xsl:copy-of select="locale/automatizzato"/>
          <xsl:if test="materiali-esclusi-locale">
            <xsl:element name="materiali-esclusi">
              <xsl:for-each select="materiali-esclusi-locale/materiale">
                <xsl:element name="materiale-escluso">
                  <xsl:value-of select="."/>
                </xsl:element>
              </xsl:for-each>
            </xsl:element>
          </xsl:if>
          <xsl:copy-of select="locale/durata"/>
          <xsl:copy-of select="locale/utenti-ammessi"/>
          <xsl:copy-of select="locale/totale-prestiti"/>
        </xsl:element>
      </xsl:if>
      <xsl:if test="interbibliotecario">
					<xsl:element name="interbibliotecario">
						<!--<xsl:attribute name="attivo">s</xsl:attribute>-->
					<xsl:copy-of select="interbibliotecario/*"/>
        </xsl:element>
      </xsl:if>
    </xsl:element>
  </xsl:template>

<!-- 
Orario, qualche elemento contenitore. Sarebbe opportuno non copiare elementi
"periodo" vuoti, ma comunque non disturbano l'import
-->

  <xsl:template match="//orario">
    <xsl:element name="orario">
      <xsl:copy-of select="ufficiale"/>
      <xsl:copy-of select="variazione"/>
      <xsl:if test="chiusura">
        <!--<xsl:element name="chiusure">-->
          <xsl:for-each select="chiusura">
            <xsl:copy-of select="."/>
          </xsl:for-each>
        <!--</xsl:element>-->
      </xsl:if>
      <xsl:copy-of select="ore-settimanali"/>
      <xsl:copy-of select="ore-settimanali-pomeridiane"/>
      <xsl:copy-of select="settimane-apertura"/>
    </xsl:element>
  </xsl:template>
</xsl:stylesheet>
