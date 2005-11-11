<?xml version="1.0"?>
<!--
  Copyright 2002-2005 The Apache Software Foundation or its licensors,
  as applicable.

  Licensed under the Apache License, Version 2.0 (the "License");
  you may not use this file except in compliance with the License.
  You may obtain a copy of the License at

      http://www.apache.org/licenses/LICENSE-2.0

  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License.
-->
<xsl:stylesheet xmlns:xsl='http://www.w3.org/1999/XSL/Transform' version='1.0'>

 <xsl:template match='/'>
  <xsl:apply-templates/>
 </xsl:template>

 <xsl:template match='@*|dtd|attlist|attributeDecl|enumeration|notationDecl'>
  <xsl:copy>
   <xsl:apply-templates select='@*|*'/>
  </xsl:copy>
 </xsl:template>

 <xsl:template match='group[count(*)=1][group]'>
  <xsl:apply-templates/>
 </xsl:template>

 <xsl:template match='contentModel|any|empty|group|pcdata|element|separator|occurrence'>
  <xsl:copy>
   <xsl:apply-templates select='@*|*'/>
  </xsl:copy>
 </xsl:template>

 <xsl:template match="comment"/>

 <xsl:template match='*'>
  <xsl:apply-templates/>
 </xsl:template>

</xsl:stylesheet>
