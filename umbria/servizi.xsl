<?xml version="1.0" ?>
<xsl:stylesheet
	version="1.0"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
>

	<xsl:output
		method="xml"
		indent="yes"/>

	<xsl:template name="servizi">
		<servizi>
			<orario>
				<xsl:variable name="mese1">
					<xsl:value-of select="substring-before(substring-after(IN/INO/INOD, '/'), '/')"/>
				</xsl:variable>
				<xsl:if test="$mese1 = '01' or $mese1 = '09' or $mese1 = '10'">
					<ufficiale>
						<xsl:for-each select="IN/INO[substring-before(substring-after(INOD, '/'), '/') = $mese1]">
							<xsl:variable name="dal">
								<xsl:value-of select="INOD"/>
							</xsl:variable>
							<xsl:variable name="al">
								<xsl:value-of select="INOA"/>
							</xsl:variable>
							<xsl:variable name="ore">
								<xsl:value-of select="INOO"/>
							</xsl:variable>
							<xsl:variable name="giorni">
								<xsl:value-of select="INOG"/>
							</xsl:variable>
							<xsl:if test="$ore">
								<xsl:if test="contains($ore, ' ')">
									<xsl:variable name="ore1">
										<xsl:value-of select="substring-before($ore, ' ')"/>
									</xsl:variable>
									<xsl:variable name="ore2">
										<xsl:value-of select="substring-after($ore, ' ')"/>
									</xsl:variable>
									<xsl:variable name="dalle1">
										<xsl:value-of select="substring-before($ore1, '-')"/>
									</xsl:variable>
									<xsl:variable name="dalle2">
										<xsl:value-of select="substring-before($ore2, '-')"/>
									</xsl:variable>
									<xsl:variable name="alle1">
										<xsl:value-of select="substring-after($ore1, '-')"/>
									</xsl:variable>
									<xsl:variable name="alle2">
										<xsl:value-of select="substring-after($ore2, '-')"/>
									</xsl:variable>
									<xsl:choose>
										<xsl:when test="contains($giorni, 'uned')">
											<orario>
												<xsl:attribute name="dalle"><xsl:value-of select="$dalle1"/></xsl:attribute>
												<xsl:attribute name="alle"><xsl:value-of select="$alle1"/></xsl:attribute>
												<xsl:attribute name="giorno">lun</xsl:attribute>
											</orario>
										</xsl:when>
										<xsl:when test="contains($giorni, 'arted')">
											<orario>
												<xsl:attribute name="dalle"><xsl:value-of select="$dalle1"/></xsl:attribute>
												<xsl:attribute name="alle"><xsl:value-of select="$alle1"/></xsl:attribute>
												<xsl:attribute name="giorno">mar</xsl:attribute>
											</orario>
										</xsl:when>
										<xsl:when test="contains($giorni, 'ercoled')">
											<orario>
												<xsl:attribute name="dalle"><xsl:value-of select="$dalle1"/></xsl:attribute>
												<xsl:attribute name="alle"><xsl:value-of select="$alle1"/></xsl:attribute>
												<xsl:attribute name="giorno">mer</xsl:attribute>
											</orario>
										</xsl:when>
										<xsl:when test="contains($giorni, 'ioved')">
											<orario>
												<xsl:attribute name="dalle"><xsl:value-of select="$dalle1"/></xsl:attribute>
												<xsl:attribute name="alle"><xsl:value-of select="$alle1"/></xsl:attribute>
												<xsl:attribute name="giorno">gio</xsl:attribute>
											</orario>
										</xsl:when>
										<xsl:when test="contains($giorni, 'enerd')">
											<orario>
												<xsl:attribute name="dalle"><xsl:value-of select="$dalle1"/></xsl:attribute>
												<xsl:attribute name="alle"><xsl:value-of select="$alle1"/></xsl:attribute>
												<xsl:attribute name="giorno">ven</xsl:attribute>
											</orario>
										</xsl:when>
										<xsl:when test="contains($giorni, 'abato')">
											<orario>
												<xsl:attribute name="dalle"><xsl:value-of select="$dalle1"/></xsl:attribute>
												<xsl:attribute name="alle"><xsl:value-of select="$alle1"/></xsl:attribute>
												<xsl:attribute name="giorno">sab</xsl:attribute>
											</orario>
										</xsl:when>
										<xsl:when test="contains($giorni, 'omenica')">
											<orario>
												<xsl:attribute name="dalle"><xsl:value-of select="$dalle1"/></xsl:attribute>
												<xsl:attribute name="alle"><xsl:value-of select="$alle1"/></xsl:attribute>
												<xsl:attribute name="giorno">dom</xsl:attribute>
											</orario>
										</xsl:when>
										<xsl:otherwise>
											<orario>
												<xsl:attribute name="dalle"><xsl:value-of select="$dalle1"/></xsl:attribute>
												<xsl:attribute name="alle"><xsl:value-of select="$alle1"/></xsl:attribute>
												<xsl:attribute name="giorno">lun</xsl:attribute>
											</orario>
											<orario>
												<xsl:attribute name="dalle"><xsl:value-of select="$dalle1"/></xsl:attribute>
												<xsl:attribute name="alle"><xsl:value-of select="$alle1"/></xsl:attribute>
												<xsl:attribute name="giorno">mar</xsl:attribute>
											</orario>
											<orario>
												<xsl:attribute name="dalle"><xsl:value-of select="$dalle1"/></xsl:attribute>
												<xsl:attribute name="alle"><xsl:value-of select="$alle1"/></xsl:attribute>
												<xsl:attribute name="giorno">mer</xsl:attribute>
											</orario>
											<orario>
												<xsl:attribute name="dalle"><xsl:value-of select="$dalle1"/></xsl:attribute>
												<xsl:attribute name="alle"><xsl:value-of select="$alle1"/></xsl:attribute>
												<xsl:attribute name="giorno">gio</xsl:attribute>
											</orario>
											<orario>
												<xsl:attribute name="dalle"><xsl:value-of select="$dalle1"/></xsl:attribute>
												<xsl:attribute name="alle"><xsl:value-of select="$alle1"/></xsl:attribute>
												<xsl:attribute name="giorno">ven</xsl:attribute>
											</orario>
										</xsl:otherwise>
									</xsl:choose>
								</xsl:if>
								<xsl:if test="not(contains($ore, ' '))">
									<xsl:variable name="dalle1">
										<xsl:value-of select="substring-before($ore, '-')"/>
									</xsl:variable>
									<xsl:variable name="alle1">
										<xsl:value-of select="substring-after($ore, '-')"/>
									</xsl:variable>
									<xsl:if test="contains($giorni, 'lun')">
										<orario>
											<xsl:attribute name="dalle"><xsl:value-of select="$dalle1"/></xsl:attribute>
											<xsl:attribute name="alle"><xsl:value-of select="$alle1"/></xsl:attribute>
											<xsl:attribute name="giorno">lun</xsl:attribute>
										</orario>
									</xsl:if>
									<xsl:if test="contains($giorni, 'arted')">
										<orario>
											<xsl:attribute name="dalle"><xsl:value-of select="$dalle1"/></xsl:attribute>
											<xsl:attribute name="alle"><xsl:value-of select="$alle1"/></xsl:attribute>
											<xsl:attribute name="giorno">mar</xsl:attribute>
										</orario>
									</xsl:if>
									<xsl:if test="contains($giorni, 'ercoled')">
										<orario>
											<xsl:attribute name="dalle"><xsl:value-of select="$dalle1"/></xsl:attribute>
											<xsl:attribute name="alle"><xsl:value-of select="$alle1"/></xsl:attribute>
											<xsl:attribute name="giorno">mer</xsl:attribute>
										</orario>
									</xsl:if>
									<xsl:if test="contains($giorni, 'ioved')">
										<orario>
											<xsl:attribute name="dalle"><xsl:value-of select="$dalle1"/></xsl:attribute>
											<xsl:attribute name="alle"><xsl:value-of select="$alle1"/></xsl:attribute>
											<xsl:attribute name="giorno">gio</xsl:attribute>
										</orario>
									</xsl:if>
									<xsl:if test="contains($giorni, 'enerd')">
										<orario>
											<xsl:attribute name="dalle"><xsl:value-of select="$dalle1"/></xsl:attribute>
											<xsl:attribute name="alle"><xsl:value-of select="$alle1"/></xsl:attribute>
											<xsl:attribute name="giorno">ven</xsl:attribute>
										</orario>
									</xsl:if>
									<xsl:if test="contains($giorni, 'abato')">
										<orario>
											<xsl:attribute name="dalle"><xsl:value-of select="$dalle1"/></xsl:attribute>
											<xsl:attribute name="alle"><xsl:value-of select="$alle1"/></xsl:attribute>
											<xsl:attribute name="giorno">sab</xsl:attribute>
										</orario>
									</xsl:if>
									<xsl:if test="contains($giorni, 'omenica')">
										<orario>
											<xsl:attribute name="dalle"><xsl:value-of select="$dalle1"/></xsl:attribute>
											<xsl:attribute name="alle"><xsl:value-of select="$alle1"/></xsl:attribute>
											<xsl:attribute name="giorno">dom</xsl:attribute>
										</orario>
									</xsl:if>
									<xsl:if
										test="not(contains($giorni, 'omenica') or contains($giorni, 'abato') or contains($giorni, 'enerd') or contains($giorni, 'ioved') or contains($giorni, 'ercoled') or contains($giorni, 'arted') or contains($giorni, 'uned'))"
									>
										<orario>
											<xsl:attribute name="dalle"><xsl:value-of select="$dalle1"/></xsl:attribute>
											<xsl:attribute name="alle"><xsl:value-of select="$alle1"/></xsl:attribute>
											<xsl:attribute name="giorno">lun</xsl:attribute>
										</orario>
										<orario>
											<xsl:attribute name="dalle"><xsl:value-of select="$dalle1"/></xsl:attribute>
											<xsl:attribute name="alle"><xsl:value-of select="$alle1"/></xsl:attribute>
											<xsl:attribute name="giorno">mar</xsl:attribute>
										</orario>
										<orario>
											<xsl:attribute name="dalle"><xsl:value-of select="$dalle1"/></xsl:attribute>
											<xsl:attribute name="alle"><xsl:value-of select="$alle1"/></xsl:attribute>
											<xsl:attribute name="giorno">mer</xsl:attribute>
										</orario>
										<orario>
											<xsl:attribute name="dalle"><xsl:value-of select="$dalle1"/></xsl:attribute>
											<xsl:attribute name="alle"><xsl:value-of select="$alle1"/></xsl:attribute>
											<xsl:attribute name="giorno">gio</xsl:attribute>
										</orario>
										<orario>
											<xsl:attribute name="dalle"><xsl:value-of select="$dalle1"/></xsl:attribute>
											<xsl:attribute name="alle"><xsl:value-of select="$alle1"/></xsl:attribute>
											<xsl:attribute name="giorno">ven</xsl:attribute>
										</orario>
									</xsl:if>
								</xsl:if>
							</xsl:if>
						</xsl:for-each>
					</ufficiale>
				</xsl:if>
			</orario>
		</servizi>
	</xsl:template>
</xsl:stylesheet>