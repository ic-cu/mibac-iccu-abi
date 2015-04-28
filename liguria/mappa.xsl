<?xml version="1.0" ?>
<xsl:stylesheet version="1.0"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <!-- il posseduto di ogni materiale è ignorato se "" (sempre con string-length) 
  c'é da verificare se un materiali vuoto cancella tutto il precedente-->

	<xsl:output method="xml" indent="yes" />
	<xsl:template name="mappa">
	<xsl:param name="d"></xsl:param>
		<xsl:choose>
<xsl:when test="$d = 'Cinquecentine'">edizioni del '500</xsl:when>
<xsl:when test="$d = 'Edizioni sec. XVII'">edizioni del '600</xsl:when>
<xsl:when test="$d = 'Edizioni sec. XVIII'">edizioni del '700</xsl:when>
<xsl:when test="$d = 'Edizioni sec. XIX'">edizioni del '800</xsl:when>
<xsl:when test="$d = 'Edizioni sec. XX-XXI (per adulti)'">volumi ed opuscoli</xsl:when>
<xsl:when test="$d = 'Edizioni sec. XX-XXI (per ragazzi)'">libri per ragazzi</xsl:when>
<xsl:when test="$d = 'Documenti cartografici moderni'">documenti cartografici</xsl:when>
<xsl:when test="$d = 'Documenti cartografici antichi (fino al 1830)'">documenti cartografici</xsl:when>
<xsl:when test="$d = 'Musica a stampa'">documenti musicali a stampa</xsl:when>
<xsl:when test="$d = 'carteggi'">Edizioni del '500</xsl:when>
<xsl:when test="starts-with($d, 'Manoscritti')">manoscritti</xsl:when>
<xsl:when test="$d = 'Bobine cinematografiche'">filmati</xsl:when>
<xsl:when test="$d = 'CD dati'">CD-ROM</xsl:when>
<xsl:when test="$d = 'Compact disc audio'">compact disc</xsl:when>
<xsl:when test="$d = 'Altri supporti per dati'">basi di dati</xsl:when>
<xsl:when test="$d = 'DVD e Blue Ray video'">DVD-video</xsl:when>
<xsl:when test="$d = 'DVD audio'">audiovisivi</xsl:when>
<xsl:when test="$d = 'DVD video'">DVD-video</xsl:when>
<xsl:when test="$d = 'DVD dati'">DVD</xsl:when>
<xsl:when test="$d = 'Stampe e incisioni'">stampeincisioni</xsl:when>
<xsl:when test="$d = 'Ebook'">e-book</xsl:when>
<xsl:when test="$d = 'Registrazioni video'">documenti audiovisivi</xsl:when>
<xsl:when test="$d = 'Cinquecentine'">Edizioni del '500</xsl:when>
<xsl:when test="$d = 'Cinquecentine'">Edizioni del '500</xsl:when>
<xsl:when test="$d = 'Cinquecentine'">Edizioni del '500</xsl:when>
	<xsl:otherwise>
		<xsl:value-of select="$d" />
	</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet>