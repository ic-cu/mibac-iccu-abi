<?xml version="1.0"?>
<xsl:stylesheet
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	version="1.0"
>

	<!-- Foglio di stile per la conversione di file 1.5 a file 1.6 -->

	<xsl:output
		method="xml"
		indent="yes"
		encoding="UTF-8"/>

	<!--
		Cataloghi, basta un solo template, ma è complicato il caso dei materiali
		nei cataloghi speciali e collettivi, in cui le forme devono ora essere
		un sottoelemento di ciascun materiale, che prima non era ripetibile
	-->

	<xsl:template match="//cataloghi">
		<cataloghi>
			<xsl:if test="catalogo-generale">
				<cataloghi-generali>
					<xsl:apply-templates select="catalogo-generale"/>
				</cataloghi-generali>
			</xsl:if>

			<xsl:if test="catalogo-speciale">
				<cataloghi-speciali>
					<xsl:for-each select="catalogo-speciale">
						<catalogo-speciale>
							<xsl:apply-templates select="nome"/>

							<!--
								Se c'è il materiale, sebbene sia uno solo, si deve creare un contenitore
								di materiali, creare in esso un materiale e copiare in quest'ultimo sia
								le forme che la tipologia
							-->

							<xsl:if test="materiale">
								<materiali>
									<xsl:for-each select="materiale">

										<!--
											Si crea il nuovo tipo di materiale. Il nome è copiato dal contenuto del
											vecchio tipo di materiale, e in più si eliminano eventuali asterischi
											finali, che nella nuova gestione non hanno più senso
										-->

										<materiale>
											<xsl:attribute name="nome">
											<xsl:if test="not(contains(., '*'))">
												<xsl:value-of select="."/>
											</xsl:if>
											<xsl:if test="contains(., '*')">
												<xsl:copy-of select="substring-before(.,'*')"/>
											</xsl:if>
										</xsl:attribute>

											<!--
												Dal livello superiore si portano forme e copertura dentro il singolo materiale
											-->

											<xsl:copy-of select="../forme"/>
											<xsl:copy-of select="../copertura"/>
										</materiale>
									</xsl:for-each>
								</materiali>
							</xsl:if>
						</catalogo-speciale>
					</xsl:for-each>
				</cataloghi-speciali>
			</xsl:if>

			<!-- Collettivi: si procede quasi come per gli speciali -->

			<xsl:if test="catalogo-collettivo">
				<cataloghi-collettivi>
					<xsl:for-each select="catalogo-collettivo">
						<catalogo-collettivo>
							<xsl:apply-templates select="nome"/>
							<xsl:if test="materiale">
								<materiali>
									<xsl:for-each select="materiale">
										<materiale>
											<xsl:attribute name="nome">
											<xsl:if test="not(contains(., '*'))">
												<xsl:value-of select="."/>
											</xsl:if>
											<xsl:if test="contains(., '*')">
												<xsl:copy-of select="substring-before(.,'*')"/>
											</xsl:if>
										</xsl:attribute>
											<xsl:apply-templates select="../forme"/>
										</materiale>
									</xsl:for-each>
								</materiali>
							</xsl:if>
							<xsl:apply-templates select="zona"/>
						</catalogo-collettivo>
					</xsl:for-each>
				</cataloghi-collettivi>
			</xsl:if>
		</cataloghi>
	</xsl:template>

	<!--
		Qualche elemento non va esportato se vuoto, o se ha figli o attributi vuoti o
		tali da rendere priva di senso l'estrazione del dato
	-->
	<xsl:template match="//catalogo-generale[not(@tipo)]"/>
	<xsl:template match="//catalogo-generale[contains(@tipo, 'per')]"/>
	<xsl:template match="//catalogo-generale/forme[not(*)]"/>
	<xsl:template match="//catalogo-collettivo/forme[not(*)]"/>

	<!--
		I cataloghi generali con molteplici punti d'accesso sono spesso
		arrivati vuoti. Quelli realmente tali acquistano
		forma/digitale/supporto=online, e quelli che hanno già questo elemento
		= "O" lo cambiano in "online", copiando eventuali altri contenuti.
		Tutti gli altri sono copiati come sono.
	-->

	<xsl:template match="//catalogo-generale">

		<xsl:if test="contains(./@tipo, 'olteplici') and not(*)">
			<catalogo-generale>
				<xsl:attribute name="tipo">Molteplici punti d'accesso</xsl:attribute>
				<forme>
					<digitale>
						<supporto>online</supporto>
					</digitale>
				</forme>
			</catalogo-generale>
		</xsl:if>

		<xsl:if test="contains(./@tipo, 'olteplici') and (forme/digitale/supporto = 'O')">
			<catalogo-generale>
				<xsl:attribute name="tipo">Molteplici punti d'accesso</xsl:attribute>
				<forme>
					<xsl:apply-templates/>
					<digitale>
						<supporto>online</supporto>
					</digitale>
				</forme>
				<xsl:apply-templates/>
			</catalogo-generale>
		</xsl:if>

<!-- 
Si ricavano tipi accettabili da quelli inviati, che però alla fine saranno
scartati perché fanno solo rumore negli import e nei controlli vari. Per ogni
tipo mappabile si imposta il valore opportuno e poi si applicano i template 
 -->

		<xsl:if test="contains(./@tipo,'Autor')">
			<catalogo-generale>
				<xsl:attribute name="tipo">Autore</xsl:attribute>
				<xsl:apply-templates select="*"/>
			</catalogo-generale>
		</xsl:if>

		<xsl:if test="contains(./@tipo,'Soggett')">
			<catalogo-generale>
				<xsl:attribute name="tipo">Soggetto</xsl:attribute>
				<xsl:apply-templates select="*"/>
			</catalogo-generale>
		</xsl:if>

		<xsl:if test="contains(./@tipo,'Titol')">
			<catalogo-generale>
				<xsl:attribute name="tipo">Titolo</xsl:attribute>
				<xsl:apply-templates select="*"/>
			</catalogo-generale>
		</xsl:if>

	</xsl:template>

	<!-- alcuni nomi di cataloghi collettivi vanno corretti o tradotti -->

	<xsl:template match="//catalogo-collettivo/nome">
		<xsl:choose>

			<xsl:when test="contains(., 'SBN')">
				<nome>Catalogo collettivo del Servizio bibliotecario nazionale, http://opac.sbn.it</nome>
			</xsl:when>

			<xsl:when test="contains(., 'EDIT 16')">
				<nome>Censimento nazionale delle Edizioni italiane del XVI secolo</nome>
			</xsl:when>

			<xsl:otherwise>
				<xsl:apply-templates select="."/>
			</xsl:otherwise>

		</xsl:choose>
	</xsl:template>

</xsl:stylesheet>
