<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

	<!-- Foglio di stile per la conversione di file 1.5 a file 1.6 -->

	<xsl:output method="xml" indent="yes" encoding="UTF-8" />

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
				<xsl:element name="cataloghi-speciali">
					<xsl:for-each select="catalogo-speciale">
						<xsl:element name="catalogo-speciale">
							<xsl:copy-of select="nome" />

							<!-- Se c'è il materiale, sebbene sia uno solo, si deve creare un 
								contenitore di materiali, creare in esso un materiale e copiare in quest'ultimo 
								sia le forme che gli la tipologia -->

							<xsl:if test="materiale">
								<xsl:element name="materiali">
									<xsl:for-each select="materiale">

										<!-- Si crea il nuovo tipo di materiale. Il nome è copiato dal 
											contenuto del vecchio tipo di materiale, e in più si eliminano eventuali 
											asterischi finali, che nella nuova gestione non hanno più senso -->

										<xsl:element name="materiale">
											<xsl:attribute name="nome">
											<xsl:if test="not(contains(., '*'))">
												<xsl:value-of select="." />
											</xsl:if>
											<xsl:if test="contains(., '*')">
												<xsl:copy-of select="substring-before(.,'*')" />
											</xsl:if>
										</xsl:attribute>

											<!-- Dal livello superiore si portano le forme dentro il singolo 
												materiale -->

											<xsl:copy-of select="../forme" />
										</xsl:element>
									</xsl:for-each>
								</xsl:element>
							</xsl:if>
						</xsl:element>
					</xsl:for-each>
				</xsl:element>
			</xsl:if>

			<!-- Collettivi: si procede quasi come per gli speciali -->

			<xsl:if test="catalogo-collettivo">
				<xsl:element name="cataloghi-collettivi">
					<xsl:for-each select="catalogo-collettivo">
						<xsl:element name="catalogo-collettivo">
							<xsl:copy-of select="nome" />
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
		</cataloghi>
	</xsl:template>

	<!-- I cataloghi generali con molteplici punti d'accesso sono spesso arrivati 
		vuoti. Quelli realmente tali acquistano forma/digitale/supporto=online, e 
		quelli che hanno già questo elemento = "O" lo cambiano in "online", copiando 
		eventuali altri contenuti. Tutti gli altri sono copiati come sono. -->

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
			<xsl:when
				test="contains(./@tipo, 'olteplici') and (forme/digitale/supporto = 'O')">
				<xsl:element name="catalogo-generale">
					<xsl:attribute name="tipo">Molteplici punti d'accesso</xsl:attribute>
					<forme>
						<xsl:copy-of select="forme/schede" />
						<xsl:copy-of select="formevolume" />
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
</xsl:stylesheet>
