<?xml version="1.0"?>
<!--
  Licensed to the Apache Software Foundation (ASF) under one or more
  license agreements.  See the NOTICE file distributed with
  this work for additional information regarding copyright ownership.
  The ASF licenses this file to You under the Apache License, Version 2.0
  (the "License"); you may not use this file except in compliance with
  the License.  You may obtain a copy of the License at

      http://www.apache.org/licenses/LICENSE-2.0

  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License.
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

    <xsl:template match="/">
        <document>
          <header>
          <title>J2SE Log Output</title>
          </header>
          <body>
            <xsl:for-each select="log/record">
              <xsl:sort select="sequence" data-type="number" order="descending"/>
              <section>
                <xsl:choose>
                  <xsl:when test="message='ENTRY'">
                    <title>Entering: <xsl:value-of select="method"/>() in <xsl:value-of select="class"/></title>
                  </xsl:when>
                  <xsl:when test="message='EXIT'">
                    <title>Exiting: <xsl:value-of select="method"/>() in <xsl:value-of select="class"/></title>
                  </xsl:when>
                  <xsl:otherwise>
                    <title><xsl:value-of select="level"/>: <xsl:value-of select="message"/></title>
                    <p>Logged By: <strong><xsl:value-of select="class"/>.<xsl:value-of select="method"/>()</strong></p>
                  </xsl:otherwise>
                </xsl:choose>
                <p>Logged At: <strong> <xsl:value-of select="date"/> (<xsl:value-of select="millis"/>)</strong></p>
              </section>
            </xsl:for-each>
          </body>
        </document>
    </xsl:template>
</xsl:stylesheet>
