<?xml version="1.0" ?>
<xsl:stylesheet version="1.0"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="xml" indent="yes" />

	<xsl:template match="PV/PVC/PVCC">
		<xsl:choose>
			<xsl:when test=". = 'Acquasparta'">
				<comune>055001</comune>
				<provincia>055</provincia>
			</xsl:when>
			<xsl:when test=". = 'Allerona'">
				<comune>055002</comune>
				<provincia>055</provincia>
			</xsl:when>
			<xsl:when test=". = 'Alviano'">
				<comune>055003</comune>
				<provincia>055</provincia>
			</xsl:when>
			<xsl:when test=". = 'Amelia'">
				<comune>055004</comune>
				<provincia>055</provincia>
			</xsl:when>
			<xsl:when test=". = 'Arrone'">
				<comune>055005</comune>
				<provincia>055</provincia>
			</xsl:when>
			<xsl:when test=". = 'Assisi'">
				<comune>054001</comune>
				<provincia>054</provincia>
			</xsl:when>
			<xsl:when test=". = 'Attigliano'">
				<comune>055006</comune>
				<provincia>055</provincia>
			</xsl:when>
			<xsl:when test=". = 'Avigliano Umbro'">
				<comune>055033</comune>
				<provincia>055</provincia>
			</xsl:when>
			<xsl:when test=". = 'Baschi'">
				<comune>055007</comune>
				<provincia>055</provincia>
			</xsl:when>
			<xsl:when test=". = 'Bastia Umbra'">
				<comune>054002</comune>
				<provincia>054</provincia>
			</xsl:when>
			<xsl:when test=". = 'Bettona'">
				<comune>054003</comune>
				<provincia>054</provincia>
			</xsl:when>
			<xsl:when test=". = 'Bevagna'">
				<comune>054004</comune>
				<provincia>054</provincia>
			</xsl:when>
			<xsl:when test="starts-with(., 'Calvi')">
				<comune>055008</comune>
				<provincia>055</provincia>
			</xsl:when>
			<xsl:when test=". = 'Campello sul Clitunno'">
				<comune>054005</comune>
				<provincia>054</provincia>
			</xsl:when>
			<xsl:when test=". = 'Cannara'">
				<comune>054006</comune>
				<provincia>054</provincia>
			</xsl:when>
			<xsl:when test=". = 'Cascia'">
				<comune>054007</comune>
				<provincia>054</provincia>
			</xsl:when>
			<xsl:when test=". = 'Castel Giorgio'">
				<comune>055009</comune>
				<provincia>055</provincia>
			</xsl:when>
			<xsl:when test=". = 'Castel Ritaldi'">
				<comune>054008</comune>
				<provincia>054</provincia>
			</xsl:when>
			<xsl:when test=". = 'Castel Viscardo'">
				<comune>055010</comune>
				<provincia>055</provincia>
			</xsl:when>
			<xsl:when test=". = 'Castiglione del Lago'">
				<comune>054009</comune>
				<provincia>054</provincia>
			</xsl:when>
			<xsl:when test=". = 'Cerreto di Spoleto'">
				<comune>054010</comune>
				<provincia>054</provincia>
			</xsl:when>
			<xsl:when test=". = 'Citerna'">
				<comune>054011</comune>
				<provincia>054</provincia>
			</xsl:when>
			<xsl:when test=". = 'Città della Pieve'">
				<comune>054012</comune>
				<provincia>054</provincia>
			</xsl:when>
			<xsl:when test=". = 'Città di Castello'">
				<comune>054013</comune>
				<provincia>054</provincia>
			</xsl:when>
			<xsl:when test=". = 'Collazzone'">
				<comune>054014</comune>
				<provincia>054</provincia>
			</xsl:when>
			<xsl:when test=". = 'Corciano'">
				<comune>054015</comune>
				<provincia>054</provincia>
			</xsl:when>
			<xsl:when test=". = 'Costacciaro'">
				<comune>054016</comune>
				<provincia>054</provincia>
			</xsl:when>
			<xsl:when test=". = 'Deruta'">
				<comune>054017</comune>
				<provincia>054</provincia>
			</xsl:when>
			<xsl:when test=". = 'Fabro'">
				<comune>055011</comune>
				<provincia>055</provincia>
			</xsl:when>
			<xsl:when test=". = 'Ferentillo'">
				<comune>055012</comune>
				<provincia>055</provincia>
			</xsl:when>
			<xsl:when test=". = 'Ficulle'">
				<comune>055013</comune>
				<provincia>055</provincia>
			</xsl:when>
			<xsl:when test=". = 'Foligno'">
				<comune>054018</comune>
				<provincia>054</provincia>
			</xsl:when>
			<xsl:when test=". = 'Fossato di Vico'">
				<comune>054019</comune>
				<provincia>054</provincia>
			</xsl:when>
			<xsl:when test=". = 'Fratta Todina'">
				<comune>054020</comune>
				<provincia>054</provincia>
			</xsl:when>
			<xsl:when test="starts-with(.,'Giano dell')">
				<comune>054021</comune>
				<provincia>054</provincia>
			</xsl:when>
			<xsl:when test=". = 'Giove'">
				<comune>055014</comune>
				<provincia>055</provincia>
			</xsl:when>
			<xsl:when test=". = 'Gualdo Cattaneo'">
				<comune>054022</comune>
				<provincia>054</provincia>
			</xsl:when>
			<xsl:when test=". = 'Gualdo Tadino'">
				<comune>054023</comune>
				<provincia>054</provincia>
			</xsl:when>
			<xsl:when test=". = 'Guardea'">
				<comune>055015</comune>
				<provincia>055</provincia>
			</xsl:when>
			<xsl:when test=". = 'Gubbio'">
				<comune>054024</comune>
				<provincia>054</provincia>
			</xsl:when>
			<xsl:when test=". = 'Lisciano Niccone'">
				<comune>054025</comune>
				<provincia>054</provincia>
			</xsl:when>
			<xsl:when test=". = 'Lugnano in Teverina'">
				<comune>055016</comune>
				<provincia>055</provincia>
			</xsl:when>
			<xsl:when test=". = 'Magione'">
				<comune>054026</comune>
				<provincia>054</provincia>
			</xsl:when>
			<xsl:when test=". = 'Marsciano'">
				<comune>054027</comune>
				<provincia>054</provincia>
			</xsl:when>
			<xsl:when test=". = 'Massa Martana'">
				<comune>054028</comune>
				<provincia>054</provincia>
			</xsl:when>
			<xsl:when test=". = 'Monte Castello di Vibio'">
				<comune>054029</comune>
				<provincia>054</provincia>
			</xsl:when>
			<xsl:when test=". = 'Monte Santa Maria Tiberina'">
				<comune>054032</comune>
				<provincia>054</provincia>
			</xsl:when>
			<xsl:when test=". = 'Montecastrilli'">
				<comune>055017</comune>
				<provincia>055</provincia>
			</xsl:when>
			<xsl:when test=". = 'Montecchio'">
				<comune>055018</comune>
				<provincia>055</provincia>
			</xsl:when>
			<xsl:when test=". = 'Montefalco'">
				<comune>054030</comune>
				<provincia>054</provincia>
			</xsl:when>
			<xsl:when test=". = 'Montefranco'">
				<comune>055019</comune>
				<provincia>055</provincia>
			</xsl:when>
			<xsl:when test=". = 'Montegabbione'">
				<comune>055020</comune>
				<provincia>055</provincia>
			</xsl:when>
			<xsl:when test="starts-with(.,'Monteleone') and contains(., 'Orvieto')">
				<comune>055021</comune>
				<provincia>055</provincia>
			</xsl:when>
			<xsl:when test=". = 'Monteleone di Spoleto'">
				<comune>054031</comune>
				<provincia>054</provincia>
			</xsl:when>
			<xsl:when test=". = 'Montone'">
				<comune>054033</comune>
				<provincia>054</provincia>
			</xsl:when>
			<xsl:when test=". = 'Narni'">
				<comune>055022</comune>
				<provincia>055</provincia>
			</xsl:when>
			<xsl:when test=". = 'Nocera Umbra'">
				<comune>054034</comune>
				<provincia>054</provincia>
			</xsl:when>
			<xsl:when test=". = 'Norcia'">
				<comune>054035</comune>
				<provincia>054</provincia>
			</xsl:when>
			<xsl:when test=". = 'Orvieto'">
				<comune>055023</comune>
				<provincia>055</provincia>
			</xsl:when>
			<xsl:when test=". = 'Otricoli'">
				<comune>055024</comune>
				<provincia>055</provincia>
			</xsl:when>
			<xsl:when test=". = 'Paciano'">
				<comune>054036</comune>
				<provincia>054</provincia>
			</xsl:when>
			<xsl:when test=". = 'Panicale'">
				<comune>054037</comune>
				<provincia>054</provincia>
			</xsl:when>
			<xsl:when test=". = 'Parrano'">
				<comune>055025</comune>
				<provincia>055</provincia>
			</xsl:when>
			<xsl:when test=". = 'Passignano sul Trasimeno'">
				<comune>054038</comune>
				<provincia>054</provincia>
			</xsl:when>
			<xsl:when test=". = 'Penna in Teverina'">
				<comune>055026</comune>
				<provincia>055</provincia>
			</xsl:when>
			<xsl:when test=". = 'Perugia'">
				<comune>054039</comune>
				<provincia>054</provincia>
			</xsl:when>
			<xsl:when test=". = 'Piegaro'">
				<comune>054040</comune>
				<provincia>054</provincia>
			</xsl:when>
			<xsl:when test=". = 'Pietralunga'">
				<comune>054041</comune>
				<provincia>054</provincia>
			</xsl:when>
			<xsl:when test=". = 'Poggiodomo'">
				<comune>054042</comune>
				<provincia>054</provincia>
			</xsl:when>
			<xsl:when test=". = 'Polino'">
				<comune>055027</comune>
				<provincia>055</provincia>
			</xsl:when>
			<xsl:when test=". = 'Porano'">
				<comune>055028</comune>
				<provincia>055</provincia>
			</xsl:when>
			<xsl:when test=". = 'Preci'">
				<comune>054043</comune>
				<provincia>054</provincia>
			</xsl:when>
			<xsl:when test=". = 'San Gemini'">
				<comune>055029</comune>
				<provincia>055</provincia>
			</xsl:when>
			<xsl:when test=". = 'San Giustino'">
				<comune>054044</comune>
				<provincia>054</provincia>
			</xsl:when>
			<xsl:when test=". = 'San Venanzo'">
				<comune>055030</comune>
				<provincia>055</provincia>
			</xsl:when>
			<xsl:when test=". = 'Sant&amp;apos;Anatolia di Narco'">
				<comune>054045</comune>
				<provincia>054</provincia>
			</xsl:when>
			<xsl:when test=". = 'Scheggia e Pascelupo'">
				<comune>054046</comune>
				<provincia>054</provincia>
			</xsl:when>
			<xsl:when test=". = 'Scheggino'">
				<comune>054047</comune>
				<provincia>054</provincia>
			</xsl:when>
			<xsl:when test=". = 'Sellano'">
				<comune>054048</comune>
				<provincia>054</provincia>
			</xsl:when>
			<xsl:when test=". = 'Sigillo'">
				<comune>054049</comune>
				<provincia>054</provincia>
			</xsl:when>
			<xsl:when test=". = 'Spello'">
				<comune>054050</comune>
				<provincia>054</provincia>
			</xsl:when>
			<xsl:when test=". = 'Spoleto'">
				<comune>054051</comune>
				<provincia>054</provincia>
			</xsl:when>
			<xsl:when test=". = 'Stroncone'">
				<comune>055031</comune>
				<provincia>055</provincia>
			</xsl:when>
			<xsl:when test=". = 'Terni'">
				<comune>055032</comune>
				<provincia>055</provincia>
			</xsl:when>
			<xsl:when test=". = 'Todi'">
				<comune>054052</comune>
				<provincia>054</provincia>
			</xsl:when>
			<xsl:when test=". = 'Torgiano'">
				<comune>054053</comune>
				<provincia>054</provincia>
			</xsl:when>
			<xsl:when test=". = 'Trevi'">
				<comune>054054</comune>
				<provincia>054</provincia>
			</xsl:when>
			<xsl:when test=". = 'Tuoro sul Trasimeno'">
				<comune>054055</comune>
				<provincia>054</provincia>
			</xsl:when>
			<xsl:when test=". = 'Umbertide'">
				<comune>054056</comune>
				<provincia>054</provincia>
			</xsl:when>
			<xsl:when test=". = 'Valfabbrica'">
				<comune>054057</comune>
				<provincia>054</provincia>
			</xsl:when>
			<xsl:when test=". = 'Vallo di Nera'">
				<comune>054058</comune>
				<provincia>054</provincia>
			</xsl:when>
			<xsl:when test=". = 'Valtopina'">
				<comune>054059</comune>
				<provincia>054</provincia>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<!-- TODO: Auto-generated template -->
</xsl:stylesheet>