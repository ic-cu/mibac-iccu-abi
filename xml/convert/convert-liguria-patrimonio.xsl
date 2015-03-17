<?xml version="1.0" ?>
<xsl:stylesheet version="1.0"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <!-- il posseduto di ogni materiale è ignorato se "" (sempre con string-length) 
  c'é da verificare se un materiali vuoto cancella tutto il precedente-->

	<xsl:output method="xml" indent="yes" />

	<xsl:template match="//scheda_BIBLIO/CONSISTENZA">
	<materiali>
		<xsl:for-each select="CATEGORIA/DETTAGLIO">
			<xsl:choose>
<xsl:when test="@descrizione = 'Cinquecentine'"><materiale nome="edizioni del '500" posseduto="{@quantita}"/></xsl:when>
<xsl:when test="@descrizione = 'Edizioni sec. XVII'"><materiale nome="edizioni del '600" posseduto="{@quantita}"/></xsl:when>
<xsl:when test="@descrizione = 'Edizioni sec. XVIII'"><materiale nome="edizioni del '700" posseduto="{@quantita}"/></xsl:when>
<xsl:when test="@descrizione = 'Edizioni sec. XIX'"><materiale nome="edizioni del '800" posseduto="{@quantita}"/></xsl:when>
<xsl:when test="@descrizione = 'Edizioni sec. XX-XXI (per adulti)'"><materiale nome="volumi ed opuscoli" posseduto="{@quantita}"/></xsl:when>
<xsl:when test="@descrizione = 'Edizioni sec. XX-XXI (per ragazzi)'"><materiale nome="volumi ed opuscoli" posseduto="{@quantita}"/></xsl:when>
<xsl:when test="@descrizione = 'Documenti cartografici moderni'"><materiale nome="documenti cartografici" posseduto="{@quantita}"/></xsl:when>
<xsl:when test="@descrizione = 'Documenti cartografici antichi (fino al 1830)'"><materiale nome="documenti cartografici" posseduto="{@quantita}"/></xsl:when>
<xsl:when test="@descrizione = 'Musica a stampa'"><materiale nome="documenti musicali a stampa" posseduto="{@quantita}"/></xsl:when>
<xsl:when test="@descrizione = 'carteggi'"><materiale nome="Edizioni del '500" posseduto="{@quantita}"/></xsl:when>
<xsl:when test="starts-with(@descrizione, 'Manoscritti')"><materiale nome="manoscritti" posseduto="{@quantita}"/></xsl:when>
<xsl:when test="@descrizione = 'Bobine cinematografiche'"><materiale nome="filmati" posseduto="{@quantita}"/></xsl:when>
<xsl:when test="@descrizione = 'CD dati'"><materiale nome="CD-ROM" posseduto="{@quantita}"/></xsl:when>
<xsl:when test="@descrizione = 'Compact disc audio'"><materiale nome="compact disc" posseduto="{@quantita}"/></xsl:when>
<xsl:when test="@descrizione = 'Altri supporti per dati'"><materiale nome="basi di dati" posseduto="{@quantita}"/></xsl:when>
<xsl:when test="@descrizione = 'DVD e Blue Ray video'"><materiale nome="DVD-video" posseduto="{@quantita}"/></xsl:when>
<xsl:when test="@descrizione = 'DVD audio'"><materiale nome="audiovisivi" posseduto="{@quantita}"/></xsl:when>
<xsl:when test="@descrizione = 'DVD video'"><materiale nome="DVD-video" posseduto="{@quantita}"/></xsl:when>
<xsl:when test="@descrizione = 'DVD dati'"><materiale nome="DVD" posseduto="{@quantita}"/></xsl:when>
<xsl:when test="@descrizione = 'Stampe e incisioni'"><materiale nome="stampe" posseduto="{@quantita}"/><materiale nome="incisioni" posseduto="{@quantita}"/></xsl:when>
<xsl:when test="@descrizione = 'Ebook'"><materiale nome="e-book" posseduto="{@quantita}"/></xsl:when>
<xsl:when test="@descrizione = 'Cinquecentine'"><materiale nome="Edizioni del '500" posseduto="{@quantita}"/></xsl:when>
<xsl:when test="@descrizione = 'Cinquecentine'"><materiale nome="Edizioni del '500" posseduto="{@quantita}"/></xsl:when>
<xsl:when test="@descrizione = 'Cinquecentine'"><materiale nome="Edizioni del '500" posseduto="{@quantita}"/></xsl:when>
<xsl:when test="@descrizione = 'Cinquecentine'"><materiale nome="Edizioni del '500" posseduto="{@quantita}"/></xsl:when>
				<xsl:otherwise>
					<materiale nome="{@descrizione}" posseduto="{@quantita}"/>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:if test="not(string-length(@quantita)=0)">
				<xsl:attribute name="posseduto">
					<xsl:value-of select="@quantita"/>
				</xsl:attribute>
			</xsl:if>
		</xsl:for-each>
		</materiali>
	</xsl:template>
	<!-- TODO: Auto-generated template -->
</xsl:stylesheet>