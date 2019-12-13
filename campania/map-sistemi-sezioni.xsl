<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	version="1.0">

	<!-- Foglio di stile per correggere o mappare alcune voci di autorità relative 
		a sistemi e reti di biblioteche e a sezioni speciali -->

	<xsl:output method="xml" indent="yes" encoding="UTF-8" />

	<!-- c'è un sistema di biblioteche errato solo a causa di un apostrofo -->

	<xsl:template match="//sistemi/sistema">
		<xsl:choose>
			<xsl:when test="contains(.,'Ateneo. Università degli Studi di Salerno')">
				<xsl:element name="sistema">
					Sistema bibliotecario di Ateneo. Università degli Studi di Salerno
				</xsl:element>
			</xsl:when>
			<xsl:when
				test="contains(., 'Sistema bibliotecario d') and contains(., 'Ateneo. Università degli Studi di Salerno')">
				<xsl:element name="sistema">
					Sistema bibliotecario di Ateneo. Università degli studi di Salerno
				</xsl:element>
			</xsl:when>
			<xsl:when
				test="contains(.,'Amina - Sistema bibliotecario cittadino di Pontecagnano Faiano')">
				<xsl:element name="sistema">
					IGNORARE: Amina - Sistema bibliotecario cittadino di Pontecagnano
					Faiano
				</xsl:element>
			</xsl:when>
			<xsl:otherwise>
				<xsl:copy-of select="." />
			</xsl:otherwise>
		</xsl:choose>

	</xsl:template>

	<!-- sezioni speciali -->

	<xsl:template match="//sezioni-speciali/sezione">
		<xsl:choose>
			<xsl:when
				test="contains(.,'Sezione Raccolta storica di testi legislativi')">
				<xsl:element name="sezione">
					legislazione italiana
				</xsl:element>
			</xsl:when>
			<xsl:when test="contains(.,'Sezione Irpinia')">
				<xsl:element name="sezione">
					Irpinia
				</xsl:element>
			</xsl:when>
			<xsl:when test="contains(.,'dialettologia')">
				<xsl:element name="sezione">
					dialetto
				</xsl:element>
			</xsl:when>
			<xsl:when test="contains(.,'sezione multiculturalità')">
				<xsl:element name="sezione">
					multiculturale
				</xsl:element>
			</xsl:when>
			<xsl:when test="contains(.,'libro parlato')">
				<xsl:element name="sezione">
					audiolibri
				</xsl:element>
			</xsl:when>
			<xsl:when test="contains(.,'Sezione Atti dei Congressi')">
				<xsl:element name="sezione">
					atti dei congressi
				</xsl:element>
			</xsl:when>
			<xsl:when test="contains(.,'Sezione Saggistica contemporanea')">
				<xsl:element name="sezione">
					saggistica
				</xsl:element>
			</xsl:when>
			<xsl:when test="contains(.,'Sezione classici della filosofia')">
				<xsl:element name="sezione">
					filosofia
				</xsl:element>
			</xsl:when>
			<xsl:when test="contains(.,'Sezione Africa e Paesi Arabi')">
				<xsl:element name="sezione">
					AFRICA e PAESI ARABI
				</xsl:element>
			</xsl:when>
			<xsl:when test="contains(.,'Fotodiapoteca')">
				<sezione>fotografia</sezione>
				<sezione>diapositive</sezione>
			</xsl:when>
			<xsl:when test="contains(.,'Economia e politica')">
				<sezione>economia</sezione>
				<sezione>politica</sezione>
			</xsl:when>
			<xsl:when test="contains(.,'sezione napoletana')">
				<sezione>napoletana</sezione>
			</xsl:when>
			<xsl:when test="contains(.,'sezione storica')">
				<sezione>storica</sezione>
			</xsl:when>
			<xsl:when test="contains(.,'Soggettività femminile')">
				<sezione>donna</sezione>
			</xsl:when>
			<xsl:when test="contains(.,'Sezione Estremo, Vicino e Medio Oriente')">
				<sezione>Estremo, Vicino e Medio Oriente</sezione>
			</xsl:when>
			<xsl:when test="contains(.,'Sezione Giorgio La Pira')">
				<sezione>GIORGIO LA PIRA</sezione>
			</xsl:when>
			<xsl:when test="contains(.,'Sezione Mondo Classico')">
				<sezione>Mondo Classico</sezione>
			</xsl:when>
			<xsl:when test="contains(.,'SezionePsiche')">
				<sezione>psiche</sezione>
			</xsl:when>
			<xsl:when test="contains(.,'Sezione Scienze umane e sociali')">
				<sezione>Scienze umane e sociali</sezione>
			</xsl:when>
			<xsl:when test="contains(.,'Sezione Studi americani')">
				<sezione>Studi americani</sezione>
			</xsl:when>
			<xsl:when
				test="contains(.,'Letteratura dell') and contains(., 'infanzia')">
				<sezione>letteratura per l'infanzia</sezione>
			</xsl:when>
			<xsl:when test="contains(.,'Internet per ragazzi')">
				<sezione>
					IGNORARE:
					<xsl:value-of select="." />
				</sezione>
			</xsl:when>
			<xsl:when test="contains(.,'Sezione disabilità (BES)')">
				<sezione>
					IGNORARE:
					<xsl:value-of select="." />
				</sezione>
			</xsl:when>
			<xsl:when test="contains(.,'Sezione favole cartonate Tira Tira')">
				<sezione>
					IGNORARE:
					<xsl:value-of select="." />
				</sezione>
			</xsl:when>
			<xsl:when test="contains(.,'sezione adulti')">
				<sezione>
					IGNORARE:
					<xsl:value-of select="." />
				</sezione>
			</xsl:when>
			<xsl:when test="contains(.,'Sezione matematico-applicativa')">
				<sezione>
					IGNORARE:
					<xsl:value-of select="." />
				</sezione>
			</xsl:when>
			<xsl:when test="contains(.,'Letteratura giovanile')">
				<sezione>
					IGNORARE:
					<xsl:value-of select="." />
				</sezione>
			</xsl:when>
			<xsl:when
				test="contains(.,'Sezione Informatica, Biblioteca Digitale, Statistica e Diffusione')">
				<sezione>
					IGNORARE:
					<xsl:value-of select="." />
				</sezione>
			</xsl:when>
			<xsl:when test="contains(.,'Sezione Mondo')">
				<sezione>
					IGNORARE:
					<xsl:value-of select="." />
				</sezione>
			</xsl:when>
			<xsl:when test="contains(.,'Sezione Progetto Comunicazione')">
				<sezione>
					IGNORARE:
					<xsl:value-of select="." />
				</sezione>
			</xsl:when>
			<xsl:when test="contains(.,'sezione moderna')">
				<sezione>
					IGNORARE:
					<xsl:value-of select="." />
				</sezione>
			</xsl:when>
			<xsl:when test="contains(.,'Sezione Tecnologico-progettuale')">
				<sezione>
					IGNORARE:
					<xsl:value-of select="." />
				</sezione>
			</xsl:when>
			<xsl:when test="contains(.,'Sezione Geronimo Stilton')">
				<sezione>
					IGNORARE:
					<xsl:value-of select="." />
				</sezione>
			</xsl:when>
			<xsl:when test="contains(.,'sezione generale')">
				<sezione>
					IGNORARE:
					<xsl:value-of select="." />
				</sezione>
			</xsl:when>
			<xsl:when test="contains(.,'Sezione Liceo classico e musicale')">
				<sezione>
					IGNORARE:
					<xsl:value-of select="." />
				</sezione>
			</xsl:when>
			<xsl:when test="contains(.,'Sezione Liceo scientifico e linguistico')">
				<sezione>
					IGNORARE:
					<xsl:value-of select="." />
				</sezione>
			</xsl:when>
			<xsl:when test="contains(.,'filosofia, storia, sociologia')">
				<sezione>
					IGNORARE:
					<xsl:value-of select="." />
				</sezione>
			</xsl:when>
			<xsl:when test="contains(.,'Sezione multiculturale')">
				<sezione>multiculturale</sezione>
			</xsl:when>
			<xsl:when test="contains(.,'Sezione ipovedenti')">
				<sezione>ipovedenti</sezione>
			</xsl:when>
			<xsl:when test="contains(.,'sezione multimediale')">
				<sezione>multimediale</sezione>
			</xsl:when>
			<xsl:when test="contains(.,'sezione locale')">
				<sezione>locale</sezione>
			</xsl:when>
			<xsl:when test="contains(.,'Sezione industria e commercio della Concia')">
				<sezione>industria e commercio della Concia</sezione>
			</xsl:when>
			<xsl:when test="contains(.,'sezione Premio Salvatore Valitutti')">
				<sezione>Premio Salvatore Valitutti</sezione>
			</xsl:when>
			<xsl:when test="contains(.,'sezione Psiche')">
				<sezione>Psiche</sezione>
			</xsl:when>
			<xsl:when test="contains(.,'Sezione Capri')">
				<sezione>Capri</sezione>
			</xsl:when>
			<xsl:when test="contains(.,'Sezione ipovedenti')">
				<sezione>ipovedenti</sezione>
			</xsl:when>


			<xsl:otherwise>
				<xsl:copy-of select="." />
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

</xsl:stylesheet>
