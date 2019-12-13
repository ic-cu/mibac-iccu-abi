<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xalan="http://xml.apache.org/xslt"
	exclude-result-prefixes="xalan" version="1.0">

	<!-- Foglio di stile per la conversione di file 1.5 a file 1.6 -->

	<xsl:output method="xml" indent="yes" encoding="UTF-8"
		xalan:indent-amount="2" />

	<!-- Cataloghi, basta un solo template, ma è complicato il caso dei materiali 
		nei cataloghi speciali e collettivi, in cui le forme devono ora essere un 
		sottoelemento di ciascun materiale, che prima non era ripetibile -->

	<xsl:template match="//cataloghi">
		<cataloghi>
			<xsl:if test="catalogo-generale">
				<cataloghi-generali>
					<xsl:apply-templates select="catalogo-generale" />
				</cataloghi-generali>
			</xsl:if>

			<xsl:if test="catalogo-speciale">
				<cataloghi-speciali>
					<xsl:for-each select="catalogo-speciale">
						<catalogo-speciale>
							<xsl:apply-templates select="nome" />

							<!-- Se c'è il materiale, sebbene sia uno solo, si deve creare un 
								contenitore di materiali, creare in esso un materiale e copiare in quest'ultimo 
								sia le forme che la tipologia -->

							<xsl:if test="materiale">
								<materiali>
									<xsl:for-each select="materiale">

										<!-- Si crea il nuovo tipo di materiale. Il nome è copiato dal 
											contenuto del vecchio tipo di materiale, e in più si eliminano eventuali 
											asterischi finali, che nella nuova gestione non hanno più senso -->

										<materiale>
											<xsl:attribute name="nome">
											<xsl:if test="not(contains(., '*'))">
												<xsl:value-of select="." />
											</xsl:if>
											<xsl:if test="contains(., '*')">
												<xsl:copy-of select="substring-before(.,'*')" />
											</xsl:if>
										</xsl:attribute>

											<!-- Dal livello superiore si portano forme e copertura dentro 
												il singolo materiale -->

											<xsl:copy-of select="../forme" />
											<xsl:copy-of select="../copertura" />
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
							<xsl:apply-templates select="nome" />
							<xsl:if test="materiale">
								<materiali>
									<xsl:for-each select="materiale">
										<materiale>
											<xsl:attribute name="nome">
												<xsl:value-of select="." />
											</xsl:attribute>
											<xsl:copy-of select="../forme" />
											<xsl:copy-of select="../copertura" />
										</materiale>
									</xsl:for-each>
								</materiali>
							</xsl:if>
						</catalogo-collettivo>
					</xsl:for-each>
					<xsl:if test="../anagrafica/codici/sbn">
						<xsl:call-template name="catalogo-sbn" />
					</xsl:if>
				</cataloghi-collettivi>
			</xsl:if>

			<!-- Se non arrivano cataloghi collettivi può essere comunque che la biblioteca 
				faccia parte di SBN. L'unico modo per saperlo è valutare "codice/sbn", fidandosi 
				della fonte, e inserire il catalogo SBN -->

			<xsl:if test="not(catalogo-collettivo)">
				<xsl:if test="../anagrafica/codici/sbn">
					<cataloghi-collettivi>
						<xsl:call-template name="catalogo-sbn" />
					</cataloghi-collettivi>
				</xsl:if>
			</xsl:if>
		</cataloghi>
	</xsl:template>

	<!-- Template "statico" per inserire il catalogo SBN -->

	<xsl:template name="catalogo-sbn">
		<catalogo-collettivo>
			<nome>Catalogo collettivo del Servizio bibliotecario nazionale,
				http://opac.sbn.it</nome>
			<materiali>
				<materiale nome="tutti i materiali">
					<forme>
						<digitale>
							<supporto>online</supporto>
							<url>http://opac.sbn.it</url>
						</digitale>
					</forme>
				</materiale>
			</materiali>
		</catalogo-collettivo>
	</xsl:template>

	<!-- Cataloghi generali. Per prima cosa vanno esclusi quelli eventualmente 
		privi di attributo tipo, che non sono ammessi -->
	<xsl:template match="//catalogo-generale[not(@tipo)]" />

	<!-- I cataloghi generali con al più tre tipi vengono convertiti in tanti 
		cataloghi per quanti tipi sono elencati nell'attributo "tipo" in input. -->

	<xsl:template match="//catalogo-generale">
		<xsl:if test="not(contains(./@tipo,'Autori / Titoli / Soggetti / Classi'))">
			<xsl:if test="contains(./@tipo,'Autor')">
				<catalogo-generale>
					<xsl:attribute name="tipo">Autore</xsl:attribute>
					<xsl:apply-templates select="*" />
				</catalogo-generale>
			</xsl:if>

			<xsl:if test="contains(./@tipo,'Soggett')">
				<catalogo-generale>
					<xsl:attribute name="tipo">Soggetto</xsl:attribute>
					<xsl:apply-templates select="*" />
				</catalogo-generale>
			</xsl:if>

			<xsl:if test="contains(./@tipo,'Titol')">
				<catalogo-generale>
					<xsl:attribute name="tipo">Titolo</xsl:attribute>
					<xsl:apply-templates select="*" />
				</catalogo-generale>
			</xsl:if>
		</xsl:if>

		<!-- I cataloghi generali con quattro tipi sono informatizzati e devono 
			avere, a parte un tipo particolare, anche la forma "digitale". Ovviamente, 
			il solito apply-templates deve escludere le forme, che altrimenti sono duplicate 
			rendendo non valido il file. Resta escluso il caso, presumibilmente assai 
			raro, di una biblioteca con codice SBN e nessun catalogo di alcun tipo. -->

		<xsl:if test="contains(./@tipo,'Autori / Titoli / Soggetti / Classi')">
			<catalogo-generale>
				<xsl:attribute name="tipo">Molteplici punti d'accesso</xsl:attribute>
				<forme>
					<digitale />
				</forme>
				<xsl:apply-templates select="*[not(local-name() = 'forme')]" />
			</catalogo-generale>
		</xsl:if>

	</xsl:template>

</xsl:stylesheet>
