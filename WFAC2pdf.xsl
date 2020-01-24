<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format">
    
    <xsl:template match="/">
        <fo:root>
            <fo:layout-master-set>
                <fo:simple-page-master master-name="wfaq-page"
                    page-height="297.0mm" page-width="209.9mm"
                    margin-bottom="8mm" margin-left="25mm" margin-right="10mm" margin-top="10mm">

                    <fo:region-body margin-bottom="28mm" margin-left="0mm" margin-right="44mm" margin-top="20mm"/>
                    
                    <fo:region-before extent="24pt" region-name="wfac-header"/>
                    
                    <fo:region-after extent="24pt" region-name="wfac-footer"/>
                    
                </fo:simple-page-master>
            </fo:layout-master-set>
            
            <fo:page-sequence master-reference="wfaq-page">
                <fo:flow flow-name="xsl-region-body" font-family="sans-serif" font-size="28pt">
                    <fo:block margin-top="40mm">
                        Wolds Outdoor Flint Archery Mail Match
                    </fo:block>
                </fo:flow>
            </fo:page-sequence>
            
            <fo:page-sequence master-reference="wfaq-page">
 
                <xsl:call-template name="header">
                </xsl:call-template>
                <fo:flow flow-name="xsl-region-body" font-family="serif" font-size="9pt">
                    <fo:block font-weight="bold" font-size="18pt">Table of Contents</fo:block>
                    <fo:list-block space-before="12pt">
                    <xsl:apply-templates select="//group" mode="toc"/>
                    </fo:list-block>
                </fo:flow>
            </fo:page-sequence>
            
            <xsl:apply-templates select="//group" mode="detail"/>
            <fo:page-sequence master-reference="wfaq-page">
                <xsl:call-template name="footer"></xsl:call-template>
                <xsl:call-template name="header"></xsl:call-template>
                <fo:flow flow-name="xsl-region-body" font-family="serif" font-size="9pt">
                    <fo:block font-weight="bold" font-size="18pt" space-after="12pt">Scorecards</fo:block>
            <xsl:apply-templates select="//groupmember" mode="scc"/>
                </fo:flow>
            </fo:page-sequence>
        </fo:root>
    </xsl:template>
    
    <!-- table of contents template -->
    <xsl:template match="group" mode="toc">
        <fo:list-item>
            <fo:list-item-label>
                <fo:block>
                    <xsl:value-of select="position()"/>.
                </fo:block>
            </fo:list-item-label>
            <fo:list-item-body start-indent="5mm">
                <fo:block>
                    <fo:inline text-decoration="underline" color="blue">
                        <fo:basic-link internal-destination="{generate-id()}" show-destination="replace">
                            Group
                    <xsl:variable name="gid" select="@group-id"/><xsl:value-of select="substring-after($gid, 'g')"/> -
                    <xsl:value-of select="date"/>
                        </fo:basic-link>
                    </fo:inline>
                </fo:block>
            </fo:list-item-body>
        </fo:list-item>
    </xsl:template>
    
    <!-- scoring template !-->
    <xsl:template match="group" mode="detail" xml:space="preserve">
        <fo:page-sequence master-reference="wfaq-page">
            
            <xsl:call-template name="footer"></xsl:call-template>
            <xsl:call-template name="header"></xsl:call-template>
            
            <fo:flow flow-name="xsl-region-body" font-family="serif" font-size="9pt">
                <fo:block id="{generate-id()}" font-size="14pt" font-weight="bold">
                    <xsl:value-of select="position()"/>. Day,
                    <xsl:value-of select="date"/>
                </fo:block>
                
                <fo:block font-size="10pt" font-weight="bold" space-before="12pt">
                    Group
                    <xsl:variable name="gid" select="@group-id"/>
                    <xsl:value-of select="substring-after($gid, 'g')"/>
                </fo:block>
                
                <fo:block font-size="9pt" space-before="12pt">
                    <xsl:for-each xml:space="preserve" select="groupmember">
                        <xsl:variable name ="id" select="@competitor-id"/>
                        <xsl:variable name="firstname" select="//competitor[@id = $id]/firstname"/>
                        <xsl:variable name="lastname" select="//competitor[@id = $id]/lastname"/>
                        <xsl:value-of select="concat($firstname, ' ', $lastname)"/>
                        (<xsl:value-of select="sum(score-card/target/arrow[./text()>0])"/>)
                        <fo:block></fo:block>
                    </xsl:for-each>
                </fo:block>
                
                <fo:block font-size="10pt" font-weight="bold" space-before="12pt">
                    <xsl:value-of select="position()"/>. Day, scoring
                </fo:block>
                
                <fo:block font-size="9pt" space-before="12pt">
                     <xsl:for-each select="groupmember">
                        <xsl:sort select="sum(score-card/target/arrow[./text()>0])" order="descending" data-type="number"/>
                        <xsl:value-of select="position()"/>. 
                        <xsl:variable name ="id" select="@competitor-id"/>
                        <xsl:variable name="firstname" select="//competitor[@id = $id]/firstname"/>
                        <xsl:variable name="lastname" select="//competitor[@id = $id]/lastname"/>
                        <xsl:value-of select="concat($firstname, ' ', $lastname)"/>
                        (<xsl:value-of select="sum(score-card/target/arrow[./text()>0])"/>)
                         <fo:block></fo:block>
                     </xsl:for-each>
                </fo:block>
            </fo:flow>
        </fo:page-sequence>
    </xsl:template>
    
    <!-- scorecard template !-->
    <xsl:template match="groupmember" mode="scc">
        <fo:block font-size="12pt" keep-with-next="always">
            <xsl:variable name ="id" select="@competitor-id"/>
            <xsl:variable name="firstname" select="//competitor[@id = $id]/firstname"/>
            <xsl:variable name="lastname" select="//competitor[@id = $id]/lastname"/>
            <xsl:variable name="gid" select="../@group-id"/>
            <xsl:variable name="gdate" select="../date"/>
            <xsl:value-of select="id(@competitor-id)/concat($firstname, ' ', $lastname, ' - Group ', substring-after($gid, 'g'), ', ',$gdate)"/>
        </fo:block>
            <xsl:call-template name="table"></xsl:call-template>
    </xsl:template>
    
    <!-- table template !-->
    <xsl:template name="table">
        <fo:table border="1pt solid black" text-align="center" space-before="12pt" space-after="12pt" page-break-inside="avoid" keep-together="always">
            <fo:table-header border="1pt solid black">
                <fo:table-row>
                    <fo:table-cell border="0.5pt solid black">
                        <fo:block>
                            target #
                        </fo:block>
                    </fo:table-cell>
                    <fo:table-cell border="0.5pt solid black">
                        <fo:block>
                            arrow 1
                        </fo:block>
                    </fo:table-cell>
                    <fo:table-cell border="0.5pt solid black">
                        <fo:block>
                            arrow 2
                        </fo:block>
                    </fo:table-cell>
                    <fo:table-cell border="0.5pt solid black">
                        <fo:block>
                            arrow 3
                        </fo:block>
                    </fo:table-cell>
                    <fo:table-cell border="0.5pt solid black">
                        <fo:block>
                            arrow 4
                        </fo:block>
                    </fo:table-cell>
                </fo:table-row>
            </fo:table-header>
            <fo:table-body>
                <xsl:for-each select="score-card">
                    <xsl:for-each select="target">
                        <fo:table-row>
                            <fo:table-cell border="0.5pt solid black">
                                <fo:block>
                                    <xsl:value-of select="position()"/>
                                </fo:block>
                            </fo:table-cell>
                            <xsl:for-each select="arrow">
                                <fo:table-cell border="0.5pt solid black">
                                    <fo:block>
                                        <xsl:value-of select="."></xsl:value-of>
                                    </fo:block>
                                </fo:table-cell>
                            </xsl:for-each>
                        </fo:table-row>
                    </xsl:for-each>
                </xsl:for-each>
            </fo:table-body>
        </fo:table>
    </xsl:template>
    
    <!-- footer template !-->
    <xsl:template name="footer">
        <fo:static-content flow-name="wfac-footer">
            <fo:block font-size="7pt" text-align="end">
                page <fo:page-number/>
            </fo:block>
        </fo:static-content>
    </xsl:template>
    
    <!-- header template !-->
    <xsl:template name="header">
        <fo:static-content flow-name="wfac-header">
            <fo:block font-size="7pt" text-align="left">
                Wolds Outdoor Flint Archery Mail Match
            </fo:block>
        </fo:static-content>
    </xsl:template>
</xsl:stylesheet>

