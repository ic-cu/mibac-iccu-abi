<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	version="1.0">
	<!-- Foglio di stile per la conversione di file 1.5 a file 1.6 -->
	<xsl:output method="xml" indent="yes" encoding="UTF-8" />
	<!--
		Template per l'elemento root che si limita a richiamare quello per ogni
		singola
		biblioteca. Inoltre valorizza l'elemento data-export se assente in input
		un dataExport
	-->
	<xsl:template match="/biblioteche">
		<xsl:element name="biblioteche">
			<xsl:attribute name="xsi:noNamespaceSchemaLocation">http://anagrafe.iccu.sbn.it/opencms/opencms/informazioni/formato-di-scambio/biblioteca-1.6.xsd</xsl:attribute>
			<xsl:if test="dataExport">
				<xsl:element name="data-export">
					<xsl:value-of select="dataExport" />
				</xsl:element>
			</xsl:if>
			<xsl:if test="not(dataExport)">
				<data-export>2000-12-31T00:00:00.000+01:00</data-export>
			</xsl:if>
			<xsl:apply-templates select="//biblioteca" />
		</xsl:element>
	</xsl:template>
	<!--
		Richiama i template per i raggruppamenti principali, mentre per le
		specializzazioni introduce un apposito contenitore e copia in esso ogni
		specializzazione trovata
	-->
	<xsl:template match="//biblioteca">
		<xsl:element name="biblioteca">
			<xsl:apply-templates select="anagrafica" />
			<xsl:apply-templates select="cataloghi" />
			<xsl:apply-templates select="patrimonio" />
			<xsl:if test="specializzazione">
				<xsl:element name="specializzazioni">
					<xsl:for-each select="specializzazione">
						<xsl:copy-of select="." />
					</xsl:for-each>
				</xsl:element>
			</xsl:if>
			<xsl:apply-templates select="servizi" />
			<xsl:apply-templates select="amministrativa" />
		</xsl:element>
	</xsl:template>
	<!--
		Anagrafica: oltre a invocare diversi template, corregge i nomi di alcune
		date, eventualmente valorizzando la data-aggiornamento se assente, e
		copiando gli indirizzi che non richiedono trattamenti
	-->
	<xsl:template match="//anagrafica">
		<xsl:element name="anagrafica">
			<xsl:if test="dataCensimento">
				<xsl:element name="data-censimento">
					<xsl:value-of select="dataCensimento" />
				</xsl:element>
			</xsl:if>
			<xsl:if test="dataAggiornamento">
				<xsl:element name="data-aggiornamento">
					<xsl:value-of select="dataAggiornamento" />
				</xsl:element>
			</xsl:if>
			<xsl:if test="not(dataAggiornamento)">
				<data-aggiornamento>2000-12-31T00:00:00.000+01:00</data-aggiornamento>
			</xsl:if>
			<fonte>
				<descrizione>Anagrafe degli Istituti Culturali Ecclesiastici (AICE)</descrizione>
				<url>http://www.anagrafebbcc.chiesacattolica.it/anagraficaCEIBib/</url>
			</fonte>
			<xsl:apply-templates select="nome" />
			<xsl:apply-templates select="codici" />
			<xsl:copy-of select="indirizzo" />
			<xsl:apply-templates select="contatti" />
			<xsl:apply-templates select="edificio" />
			<xsl:apply-templates select="Istituzione" />
		</xsl:element>
	</xsl:template>
	<!-- I nomi ora vanno in appositi contenitori -->
	<xsl:template match="//nome">
		<xsl:element name="nomi">
			<xsl:copy-of select="attuale" />
			<xsl:if test="precedente">
				<xsl:element name="precedenti">
					<xsl:for-each select="precedente">
						<xsl:copy-of select="." />
					</xsl:for-each>
				</xsl:element>
			</xsl:if>
			<xsl:if test="alternativo">
				<xsl:element name="alternativi">
					<xsl:for-each select="alternativo">
						<xsl:copy-of select="." />
					</xsl:for-each>
				</xsl:element>
			</xsl:if>
		</xsl:element>
	</xsl:template>
	<!-- Contenitori anche per i contatti -->
	<xsl:template match="//contatti">
		<xsl:element name="contatti">
			<xsl:if test="telefonico">
				<xsl:element name="telefonici">
					<xsl:for-each select="telefonico">
						<xsl:copy-of select="." />
					</xsl:for-each>
				</xsl:element>
			</xsl:if>
			<xsl:if test="altro">
				<xsl:element name="altri">
					<xsl:for-each select="altro">
						<xsl:copy-of select="." />
					</xsl:for-each>
				</xsl:element>
			</xsl:if>
		</xsl:element>
	</xsl:template>
	<!-- In edificio vanno corretti alcuni nomi -->
	<xsl:template match="//edificio">
		<xsl:element name="edificio">
			<xsl:copy-of select="denominazione" />
			<xsl:copy-of select="monumentale" />
			<xsl:if test="appositamenteCostruito">
				<xsl:element name="appositamente-costruito">
					<xsl:value-of select="appositamenteCostruito" />
				</xsl:element>
			</xsl:if>
			<!--
				Sempre in edificio, viene gestita la data di costruzione, copiando anche
				l'attributo "tipo" per distinguere anni e secoli. Dev'esserci un modo
				più semplice di farlo
			-->
			<xsl:if test="dataCostruzione">
				<xsl:element name="data-costruzione">
					<xsl:if test="dataCostruzione/@tipo">
						<xsl:attribute name="tipo">
							<xsl:value-of select="dataCostruzione/@tipo" />
						</xsl:attribute>
					</xsl:if>
					<xsl:value-of select="dataCostruzione" />
				</xsl:element>
			</xsl:if>
		</xsl:element>
	</xsl:template>
	<!--
		Converte nomi in Istituzone, cominciando proprio con questo elemento.
		Gestisce anche gli attributi "tipo" delle date, per distinguere anni e
		secoli
	-->
	<xsl:template match="//Istituzione">
		<xsl:element name="istituzione">
			<xsl:if test="dataIstituzione">
				<xsl:element name="data-istituzione">
					<xsl:if test="dataIstituzione/@tipo">
						<xsl:attribute name="tipo">
							<xsl:value-of select="dataIstituzione/@tipo" />
						</xsl:attribute>
					</xsl:if>
					<xsl:value-of select="dataIstituzione" />
				</xsl:element>
			</xsl:if>
			<xsl:if test="dataFondazione">
				<xsl:element name="data-fondazione">
					<xsl:if test="dataFondazione/@tipo">
						<xsl:attribute name="tipo">
							<xsl:value-of select="dataFondazione/@tipo" />
						</xsl:attribute>
					</xsl:if>
					<xsl:value-of select="dataFondazione" />
				</xsl:element>
			</xsl:if>
		</xsl:element>
	</xsl:template>
	<!--
		Corregge il nome del codice ISIL e anche il suo valorei, ma solo se
		manca l'IT- e non è lungo 6
	-->
	<xsl:template match="//codici">
		<xsl:element name="codici">
			<xsl:if test="not(string-length(iccu) = 9)">
				<xsl:comment>
					*** CODICE ISIL ERRATO ***
				</xsl:comment>
			</xsl:if>
			<xsl:element name="isil">
				<xsl:if test="not(starts-with(iccu, 'IT-'))">
					<xsl:value-of select="concat('IT-', iccu)" />
				</xsl:if>
				<xsl:if test="starts-with(iccu, 'IT-')">
					<xsl:value-of select="iccu" />
				</xsl:if>
			</xsl:element>
			<xsl:copy-of select="acnp" />
			<xsl:copy-of select="rism" />
			<xsl:copy-of select="sbn" />
			<xsl:copy-of select="cei" />
			<xsl:copy-of select="cmbs" />
		</xsl:element>
	</xsl:template>
	<!--
		Cataloghi, basta un solo template, ma è complicato il caso dei materiali
		nei cataloghi speciali e collettivi, in cui le forme devono ora essere
		un sottoelemento di ciascun materiale, che prima non era ripetibile
	-->
	<xsl:template match="//cataloghi">
		<xsl:element name="cataloghi">
			<xsl:if test="catalogo-generale">
				<xsl:element name="cataloghi-generali">
					<xsl:apply-templates select="catalogo-generale" />
					<!--
						<xsl:for-each select="catalogo-generale">
						<xsl:copy-of select="."/>
						</xsl:for-each>

					-->
				</xsl:element>
			</xsl:if>
			<xsl:if test="catalogo-speciale">
				<xsl:element name="cataloghi-speciali">
					<xsl:for-each select="catalogo-speciale">
						<xsl:element name="catalogo-speciale">
							<xsl:copy-of select="nome" />
							<!--
								Se c'è il materiale, sebbene sia uno solo, si deve creare un contenitore
								di materiali, creare in esso un materiale e copiare in quest'ultimo
								sia
								le forme che gli la tipologia
							-->
							<xsl:if test="materiale">
								<xsl:element name="materiali">
									<xsl:for-each select="materiale">
										<!--
											Si crea il nuovo tipo di materiale. Il nome è copiato dal contenuto
											del
											vecchio tipo di materiale, e in più si eliminano eventuali asterischi
											finali, che nella nuova gestione non hanno più senso
										-->
										<xsl:element name="materiale">
											<xsl:attribute name="nome">
											<xsl:if test="not(contains(., '*'))">
												<xsl:value-of select="." />
											</xsl:if>
											<xsl:if test="contains(., '*')">
												<xsl:copy-of select="substring-before(.,'*')" />
											</xsl:if>
										</xsl:attribute>
											<!--
												Dal livello superiore si portano le forme dentro il singolo materiale
											-->
											<xsl:copy-of select="../forme" />
										</xsl:element>
									</xsl:for-each>
								</xsl:element>
							</xsl:if>
						</xsl:element>
					</xsl:for-each>
				</xsl:element>
			</xsl:if>
			<!-- Collettivi: si procede quasi come per gli speciali
			C'è anche qualche voce da mappare -->
	<!-- non sappiamo se servirà <xsl:when test="nome = 'Catalogo collettivo regionale delle edizioni del XVI secolo'">Censimento regionale delle Edizioni del XVI secolo dell'Emilia-Romagna</xsl:when> -->
			<xsl:if test="catalogo-collettivo">
				<xsl:element name="cataloghi-collettivi">
					<xsl:for-each select="catalogo-collettivo">
						<xsl:element name="catalogo-collettivo">
							<xsl:if test="nome">
								<xsl:element name="nome">
									<xsl:choose>
										<xsl:when test="nome = 'CEIbib'">Polo Biblioteche Ecclesiastiche</xsl:when>
										<xsl:when test="nome = 'Catalogo collettivo dei periodici di Reggio Calabria'">Catalogo collettivo dei periodici delle biblioteche di Reggio Calabria</xsl:when>
										<xsl:when test="nome = 'Censimento Regionale Edizioni XVI secolo'">Catalogo collettivo regionale delle edizioni del XVI secolo</xsl:when>
										<xsl:when test="nome = concat ('Censimento regionale delle Edizioni XVI secolo dell',&quot;'&quot;, 'Emilia-Romagna')">Catalogo collettivo regionale delle edizioni del XVI secolo</xsl:when>
										<xsl:when test="nome = 'Edit16'">Censimento nazionale delle edizioni italiane del XVI secolo</xsl:when>
										<xsl:when test="nome = 'Poo Biblioteche Ecclesistiche'">Polo Biblioteche Ecclesiastiche</xsl:when>
										<xsl:when test="nome = 'Sistema bibliotecario parmense, http://opacsol.unipr.it/SebinaOpac/Opac'">Catalogo Sistema bibliotecario parmense, http://opac.unipr.it</xsl:when>
										<xsl:when test="nome = concat('Catalogo edizioni antiche di Terra d', &quot;''&quot;, 'Otranto')">Catalogo edizioni antiche di Terra d'Otranto</xsl:when>
										<xsl:when test="nome = 'Catalogo collettivo del Sistema Bibliotecario Pratese'">Catalogo collettivo provinciale pratese</xsl:when>
										<xsl:when test="nome = 'Catalogo italiano dei peridici ACNP'">Archivio collettivo nazionale delle pubblicazioni periodiche - ACNP</xsl:when>
										<xsl:when test="nome = 'Catalogo nazionale dei periodici ACNP'">Archivio collettivo nazionale delle pubblicazioni periodiche - ACNP</xsl:when>
										<xsl:when test="nome = 'Archivio collettivo nazionale delle pubblicazioni periodiche'">Archivio collettivo nazionale delle pubblicazioni periodiche - ACNP</xsl:when>
										<xsl:when test="nome = 'Censimento nazionale delle edizioni italiane del XVI secolo (EDIT16)'">Censimento nazionale delle Edizioni italiane del XVI secolo</xsl:when>
										<xsl:when test="nome = 'Incunabula Short Title Catalogue'">ISTC - Incunabola Short Title Catalogue</xsl:when>
										<xsl:when test="nome = concat('Sistema documentario integrato dell', &quot;'&quot;, 'area firoentina')">Sistema documentario integrato dell'area fiorentina</xsl:when>
										<xsl:when test="nome = ''"></xsl:when>
										<xsl:otherwise>
											<xsl:value-of select="nome" />
										</xsl:otherwise>
									</xsl:choose>
								</xsl:element>
							</xsl:if>
							<xsl:if test="materiale">
								<xsl:element name="materiali">
									<xsl:for-each select="materiale">
										<xsl:element name="materiale">
											<xsl:attribute name="nome">
											<xsl:if test="not(contains(., '*'))">
												<xsl:value-of select="." />
											</xsl:if>
											<xsl:if test="contains(., '*')">
												<xsl:copy-of select="substring-before(.,'*')" />
											</xsl:if>
										</xsl:attribute>
											<xsl:copy-of select="../forme" />
										</xsl:element>
									</xsl:for-each>
								</xsl:element>
							</xsl:if>
						</xsl:element>
					</xsl:for-each>
				</xsl:element>
			</xsl:if>
		</xsl:element>
	</xsl:template>
	<!--
		Patrimonio, basta un solo template, ma c'è da gestire gli asterischi
	-->
	<xsl:template match="//patrimonio">
		<xsl:element name="patrimonio">
			<xsl:if test="materiale">
				<xsl:element name="materiali">
					<xsl:for-each select="materiale">
						<xsl:element name="materiale">
							<xsl:attribute name="nome">
							  <xsl:if test="not(contains(@nome, '*'))">
									<xsl:value-of select="@nome" />
								</xsl:if>
							  <xsl:if test="contains(@nome, '*')">
									<xsl:copy-of select="substring-before(@nome,'*')" />
								</xsl:if>
							</xsl:attribute>
							<xsl:copy-of select="@posseduto" />
							<xsl:copy-of select="@acquisti-ultimo-anno" />
						</xsl:element>
					</xsl:for-each>
				</xsl:element>
			</xsl:if>
			<xsl:if test="fondo-speciale">
				<xsl:element name="fondi-speciali">
					<xsl:for-each select="fondo-speciale">
						<xsl:element name="fondo-speciale">
							<xsl:copy-of select="nome" />
							<xsl:copy-of select="descrizione" />
							<xsl:copy-of select="cdd" />
							<xsl:copy-of select="depositato" />
							<xsl:if test="catalogoInventario">
								<xsl:element name="catalogo-inventario">
									<xsl:value-of select="catalogoInventario" />
								</xsl:element>
							</xsl:if>
							<xsl:if test="catalogoInventarioUrl">
								<xsl:element name="catalogo-inventario-url">
									<xsl:value-of select="catalogoInventarioUrl" />
								</xsl:element>
							</xsl:if>
						</xsl:element>
					</xsl:for-each>
				</xsl:element>
			</xsl:if>
			<xsl:copy-of select="fondi-antichi" />
			<xsl:copy-of select="inventario" />
			<xsl:copy-of select="catalogo-topografico" />
			<xsl:copy-of select="acquisti-ultimi-quindici-anni" />
			<xsl:copy-of select="totale-posseduto" />
			<xsl:copy-of select="totale-posseduto-ragazzi" />
		</xsl:element>
	</xsl:template>
	<!--
		Servizi, qui servono diversi template e va gestito l'attributo "attivo"
	-->
	<xsl:template match="//servizi">
		<xsl:element name="servizi">
			<xsl:apply-templates select="orario" />
			<xsl:apply-templates select="prestito" />
			<xsl:if test="riproduzioni">
				<xsl:element name="riproduzioni">
					<xsl:attribute name="attivo">s</xsl:attribute>
					<xsl:for-each select="riproduzioni">
						<xsl:element name="riproduzione">
							<xsl:element name="tipo">
								<xsl:copy-of select="normalize-space(tipo)" />
							</xsl:element>
							<xsl:if test="locale">
								<xsl:element name="locale">
									<xsl:copy-of select="normalize-space(locale)" />
								</xsl:element>
							</xsl:if>
							<xsl:if test="nazionale">
								<xsl:element name="nazionale">
									<xsl:copy-of select="normalize-space(nazionale)" />
								</xsl:element>
							</xsl:if>
							<xsl:if test="internazionale">
								<xsl:element name="internazionale">
									<xsl:copy-of select="normalize-space(internazionale)" />
								</xsl:element>
							</xsl:if>
						</xsl:element>
					</xsl:for-each>
				</xsl:element>
			</xsl:if>
			<xsl:copy-of select="materiali-esclusi-locale" />
			<xsl:if test="informazioni-bibliografiche">
				<xsl:element name="informazioni-bibliografiche">
					<xsl:attribute name="attivo">s</xsl:attribute>
					<xsl:copy-of select="informazioni-bibliografiche/*" />
				</xsl:element>
			</xsl:if>
			<!--
				Gestione dell'accesso a internet. Si è passati ad una gestione più coerente,
				per cui vanno valorizzati tre flag in base a valori opportuni dell'elemento
				sorgente, che era una semplice stringa. Inoltre, se presente l'elemento,
				anche
				vuoto, va valorizzato l'attributo "attivo"
			-->
			<xsl:if test="internet">
				<xsl:element name="internet">
					<xsl:attribute name="attivo">s</xsl:attribute>
					<xsl:if test="internet/modo = 'limitato'">
						<con-proxy>s</con-proxy>
					</xsl:if>
					<xsl:if test="internet/modo = 'Selezionato'">
						<con-proxy>s</con-proxy>
					</xsl:if>
					<xsl:if test="internet/modo = 'libero'">
						<con-proxy>n</con-proxy>
					</xsl:if>
					<xsl:if test="internet/modo = 'Libero'">
						<con-proxy>n</con-proxy>
					</xsl:if>
					<xsl:if test="internet/modo = 'A pagamento'">
						<a-pagamento>s</a-pagamento>
					</xsl:if>
					<xsl:if test="internet/modo = 'A tempo'">
						<a-tempo>s</a-tempo>
					</xsl:if>
				</xsl:element>
			</xsl:if>
			<xsl:apply-templates select="accesso" />
			<xsl:call-template name="sistemi" />
			<xsl:copy-of select="sezioni-speciali" />
			<xsl:apply-templates select="reference" />
		</xsl:element>
	</xsl:template>
	<xsl:template match="reference">
		<xsl:element name="reference">
			<xsl:attribute name="attivo">
				<xsl:value-of select="@attivo	" />	
			</xsl:attribute>
			<xsl:if test="locale">
				<xsl:element name="locale">
					<xsl:copy-of select="normalize-space(locale)" />
				</xsl:element>
			</xsl:if>
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
			<!--
				<xsl:copy-of select="aperta"/>
			-->
			<aperta>s</aperta>
			<xsl:copy-of select="handicap" />
			<xsl:if test="condizioni-accesso/*">
				<xsl:element name="modalita-accesso">
					<xsl:for-each select="condizioni-accesso/documenti/tipo">
						<xsl:element name="modo">
							<xsl:value-of select="." />
						</xsl:element>
					</xsl:for-each>
					<xsl:for-each select="condizioni-accesso/eta[@min]">
						<xsl:element name="modo">
							<xsl:text>Limite di eta': &gt;= </xsl:text>
							<xsl:value-of select="@min" />
						</xsl:element>
					</xsl:for-each>
					<xsl:for-each select="condizioni-accesso/eta[@max]">
						<xsl:element name="modo">
							<xsl:text>Limite di eta': &lt;= </xsl:text>
							<xsl:value-of select="@max" />
						</xsl:element>
					</xsl:for-each>
					<!--
						Il "modo" appuntamento arriva sempre in due forme (elemento e testo),
						per cui quella per elemento si scarta.
						<xsl:if test="condizioni-accesso/appuntamento">
						<xsl:element name="modo">
						<xsl:text>appuntamento</xsl:text>
						</xsl:element>
						</xsl:if>
					-->
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
					<xsl:copy-of select="." />
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
					<xsl:copy-of select="locale/automatizzato" />
					<xsl:if test="materiali-esclusi-locale">
						<xsl:element name="materiali-esclusi">
							<xsl:for-each select="materiali-esclusi-locale/materiale">
								<xsl:element name="materiale-escluso">
									<xsl:value-of select="." />
								</xsl:element>
							</xsl:for-each>
						</xsl:element>
					</xsl:if>
					<xsl:copy-of select="locale/durata" />
					<xsl:apply-templates select="locale/utenti-ammessi" />
					<xsl:copy-of select="locale/totale-prestiti" />
				</xsl:element>
			</xsl:if>
			<xsl:if test="interbibliotecario">
				<xsl:element name="interbibliotecario">
					<!--<xsl:attribute name="attivo">s</xsl:attribute> -->
					<xsl:copy-of select="interbibliotecario/*" />
				</xsl:element>
			</xsl:if>
		</xsl:element>
	</xsl:template>
	<xsl:template match="locale/utenti-ammessi" name="tokenize">
		<xsl:param name="text" select="text()" />
		<xsl:param name="separator" select="','" />
		<xsl:choose>
			<xsl:when test="not(contains($text, $separator))">
				<utenti-ammessi>
					<xsl:value-of select="normalize-space($text)" />
				</utenti-ammessi>
			</xsl:when>
			<xsl:otherwise>
				<utenti-ammessi>
					<xsl:value-of select="normalize-space(substring-before($text, $separator))" />
				</utenti-ammessi>
				<xsl:call-template name="tokenize">
					<xsl:with-param name="text" select="substring-after($text, $separator)" />
				</xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!--
		Orario, qualche elemento contenitore. Sarebbe opportuno non copiare elementi
		"periodo" vuoti, ma comunque non disturbano l'import
	-->
	<xsl:template match="//orario">
		<xsl:element name="orario">
			<xsl:copy-of select="ufficiale" />
			<xsl:copy-of select="variazione" />
			<xsl:if test="chiusura">
				<!--<xsl:element name="chiusure"> -->
				<xsl:for-each select="chiusura">
					<xsl:copy-of select="." />
				</xsl:for-each>
				<!--</xsl:element> -->
			</xsl:if>
			<xsl:copy-of select="ore-settimanali" />
			<xsl:copy-of select="ore-settimanali-pomeridiane" />
			<xsl:copy-of select="settimane-apertura" />
		</xsl:element>
	</xsl:template>
	<!-- sezione amministrativa, va copiato tutto eccetto la funzione-obiettivo;
		sicuramente il template si può fare molto meglio di così -->
	<xsl:template match="//amministrativa">
		<xsl:element name="amministrativa">
			<xsl:copy-of select="codice-fiscale" />
			<xsl:copy-of select="partita-iva" />
			<xsl:copy-of select="autonoma" />
			<xsl:apply-templates select="ente" />
			<xsl:copy-of select="regolamento" />
			<xsl:copy-of select="carta-servizi" />
			<xsl:copy-of select="depositi-legali" />
			<xsl:copy-of select="strutture" />
			<xsl:copy-of select="utenti" />
			<xsl:copy-of select="personale" />
			<xsl:copy-of select="bilancio" />
		</xsl:element>
	</xsl:template>
	<xsl:template match="//ente">
		<xsl:element name="ente">
			<xsl:copy-of select="nome" />
			<xsl:copy-of select="tipologia-amministrativa" />
			<xsl:copy-of select="tipologia-funzionale" />
			<xsl:copy-of select="stato" />
			<xsl:copy-of select="codice-fiscale" />
			<xsl:copy-of select="partita-iva" />
		</xsl:element>
	</xsl:template>
	<!--
		I cataloghi generali con molteplici punti d'accesso sono spesso
		arrivati vuoti. Quelli realmente tali acquistano
		forma/digitale/supporto=online, e quelli che hanno già questo elemento
		= "O" lo cambiano in "online", copiando eventuali altri contenuti.
		Tutti gli altri sono copiati come sono.
	-->
	<xsl:template match="//catalogo-generale">
		<xsl:choose>
			<xsl:when test="contains(./@tipo, 'olteplici') and not(*)">
				<xsl:element name="catalogo-generale">
					<xsl:attribute name="tipo">Molteplici punti d'accesso</xsl:attribute>
					<forme>
						<digitale>
							<supporto>online</supporto>
						</digitale>
					</forme>
				</xsl:element>
			</xsl:when>
			<xsl:when test="contains(./@tipo, 'olteplici') and (forme/digitale/supporto = 'O')">
				<xsl:element name="catalogo-generale">
					<xsl:attribute name="tipo">Molteplici punti d'accesso</xsl:attribute>
					<forme>
						<xsl:apply-templates select="forme/schede" />
						<xsl:copy-of select="forme/volume" />
						<xsl:copy-of select="forme/microforme" />
						<digitale>
							<supporto>online</supporto>
						</digitale>
					</forme>
					<xsl:copy-of select="copertura" />
				</xsl:element>
			</xsl:when>
			<xsl:otherwise>
				<xsl:copy-of select="." />
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	<xsl:template match="forme/schede">
		<schede>
			<xsl:if test="@percentuale">
				<xsl:attribute name="percentuale">
					<xsl:if test="contains(@percentuale, '%')">
						<xsl:value-of select="translate(@percentuale, '%', '')"/>
					</xsl:if>
					<xsl:if test="not(contains(@percentuale, '%'))">
						<xsl:value-of select="@percentuale"/>
					</xsl:if>
				</xsl:attribute>
			</xsl:if>
		</schede>
	</xsl:template>
</xsl:stylesheet>