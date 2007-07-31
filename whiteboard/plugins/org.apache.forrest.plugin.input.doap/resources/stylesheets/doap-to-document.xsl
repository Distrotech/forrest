<?xml version="1.0"?>
<!--
  Licensed to the Apache Software Foundation (ASF) under one or more
  contributor license agreements.  See the NOTICE file distributed with
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
<xsl:stylesheet version = "1.0"
                xmlns:atom="http://www.w3.org/2005/Atom"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" 
                xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#" 
                xmlns:doap="http://usefulinc.com/ns/doap#"
                xmlns:foaf="http://xmlns.com/foaf/0.1/"
	            xmlns:dc="http://purl.org/dc/elements/1.1/"
                xmlns:asfext="http://projects.apache.org/ns/asfext#"
                >                
  <xsl:template match="/">
    <xsl:apply-templates select="projectDetails" />
  </xsl:template>
  <xsl:template match="projectDetails">
    <xsl:apply-templates select="doap:Project|rdf:RDF|atom:feed"/>
  </xsl:template>
  <xsl:template match="rdf:RDF">
    <xsl:apply-templates select="doap:Project" />
  </xsl:template>
  <xsl:template match="atom:feed">
    <xsl:apply-templates select="atom:entry/atom:content/doap:Project" />
  </xsl:template>
  <xsl:template match="doap:Project">
    <document>
      <xsl:call-template name="header" />
      <xsl:call-template name="body" />
    </document>
  </xsl:template>

  <xsl:template name="header">
    <header><link rel="stylesheet" type="text/css" href="../html/projects.css" />
      <title>Information about <xsl:value-of select="doap:name"/></title>
    </header>
  </xsl:template>
  <xsl:template name="body">
    <body>
      <xsl:call-template name="project-header" />
      <xsl:call-template name="project-summary" />
      <xsl:call-template name="project-contributors" />
      <section>
        <title>Description</title>
        <xsl:choose>
          <xsl:when test="doap:description">
            <p>
              <xsl:value-of select="doap:description"/>
            </p>
          </xsl:when>
          <xsl:otherwise>
            <p>
              No description supplied.
            </p>
          </xsl:otherwise>
        </xsl:choose>
      </section>
      <xsl:call-template name="project-releases" />
      
      <xsl:if test="foaf:seeAlso[@dc:format='application/rss+xml' or @dc:format='application/atom+xml']">
        <section>
          <title>News Feeds</title>
        <!-- we need the empty statement in the following script element
otherwise it doesn't load for some reason -->
        <script type="text/javascript"
            src="http://www.google.com/jsapi?key=ABQIAAAA6Z-D4RJHDFYPA_4r805bNBS35Y06UsNZ7zMjADH_v2yM8_26AhRQPRif3s-hl0DX2y8IOnAwSo3WgA">;</script>
            
        <xsl:element name="script">
          <xsl:attribute name="type">text/javascript</xsl:attribute>
                google.load("feeds", "1");
             
                function initialize() {
                  var feedControl = new google.feeds.FeedControl();
                  <xsl:for-each select="foaf:seeAlso[@dc:format='application/rss+xml' or @dc:format='application/atom+xml']">
                    feedControl.addFeed('<xsl:value-of select="./@rdf:resource"/>', '<xsl:value-of select="./@dc:title"/>');
                  </xsl:for-each>
                  feedControl.draw(document.getElementById('Feeds'),
                      {
                        drawMode : google.feeds.FeedControl.DRAW_MODE_TABBED
                      });
                }
                google.setOnLoadCallback(initialize);
         </xsl:element>
         <div id="Feeds">
           <p>Loading feeds...</p>
         </div>
         </section>
       </xsl:if>
    </body>
  </xsl:template>
  <xsl:template match="@rdf:resource"><a>
    <xsl:attribute name="href">
      <xsl:value-of select="."/>
    </xsl:attribute>
    <xsl:value-of select="."/></a>
  </xsl:template>
  <xsl:template match="doap:programming-language"><a>
    <xsl:attribute name="href">/projectDetails/index/byLang/<xsl:value-of select="."/>.html</xsl:attribute>
    <xsl:value-of select="."/></a>
    <xsl:if test="not(position() = last())">
<xsl:text>, </xsl:text>
    </xsl:if>
  </xsl:template>
  <xsl:template match="doap:category">
    <xsl:variable name="category" select="@rdf:resource"/>
    <li>
        <xsl:choose>
          <xsl:when test="//projectDetails/categories/doap:category[@rdf:resource = $category]/@dc:title">
            <xsl:value-of select="//projectDetails/categories/doap:category[@rdf:resource = $category]/@dc:title"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:choose>
              <xsl:when test="@dc:title">
                <xsl:value-of select="@dc:title"/>
              </xsl:when>
              <xsl:otherwise>
                <xsl:value-of select="@rdf:resource"/>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:otherwise>
        </xsl:choose>
    </li>
  </xsl:template>
  <xsl:template match="foaf:seeAlso">
    <xsl:choose>
      <xsl:when test="@dc:format='application/rss+xml'">
        <a class="rss-rss-link">
            <xsl:attribute name="href">
              <xsl:value-of select="@rdf:resource"/>
            </xsl:attribute> 
            <xsl:choose>
              <xsl:when test="@dc:title">
                <xsl:value-of select="@dc:title"/>
              </xsl:when>
              <xsl:otherwise>RSS</xsl:otherwise>
            </xsl:choose>
        </a>
      </xsl:when>
      <xsl:when test="@dc:format='application/atom+xml'">
        <a class="rss-atom-link">        
            <xsl:attribute name="href">
              <xsl:value-of select="@rdf:resource"/>
            </xsl:attribute> 
            <xsl:choose>
              <xsl:when test="@dc:title">
                <xsl:value-of select="@dc:title"/>
              </xsl:when>
              <xsl:otherwise>ATOM</xsl:otherwise>
            </xsl:choose>
        </a>
      </xsl:when>
      <xsl:when test="@dc:format='application/rdf+xml'">
        <a class="rss-rdf-link">
            <xsl:attribute name="href">
              <xsl:value-of select="@rdf:resource"/>
            </xsl:attribute> 
            <xsl:choose>
              <xsl:when test="@dc:title">
                <xsl:value-of select="@dc:title"/>
              </xsl:when>
              <xsl:otherwise>RDF</xsl:otherwise>
            </xsl:choose>
        </a>
      </xsl:when>
    </xsl:choose>
  </xsl:template>
  <xsl:template name="project-header">
    <div class="description">
      <p>
        <xsl:value-of select="doap:shortdesc"/>
      </p>
      <xsl:if test="doap:homepage">
        <p>
          For more information visit
          <xsl:apply-templates select="doap:homepage/@*" />
        </p>
      </xsl:if>
    </div>
  </xsl:template>
  <xsl:template name="project-summary">
    <section>
      <title>Summary</title>
      <div class="content">
        <table>
          <tr>
            <td class="left">Programming Languages</td>
            <td class="right">
              <xsl:choose>
                <xsl:when test="doap:programming-language">
                  <xsl:apply-templates select="doap:programming-language" />
                </xsl:when>
                <xsl:otherwise>
                       None Defined
                     </xsl:otherwise>
              </xsl:choose>
            </td>
          </tr>
          <tr>
            <td class="left">Categories</td>
            <td class="right">
              <xsl:choose>
                <xsl:when test="doap:category">
                  <ul>
                    <xsl:apply-templates select="doap:category" />
                  </ul>
                </xsl:when>
                <xsl:otherwise>
                       None Defined
                     </xsl:otherwise>
              </xsl:choose>
            </td>
          </tr>
          <tr>
            <td class="left">Mailing Lists</td>
            <td class="right">
              <xsl:choose>
                <xsl:when test="doap:mailing-list/@*">
                  <xsl:apply-templates select="doap:mailing-list/@*" />
                </xsl:when>
                <xsl:otherwise>
                       None Defined
                     </xsl:otherwise>
              </xsl:choose>
            </td>
          </tr>
          <tr>
            <td class="left">Bug/Issue Tracker</td>
            <td class="right">
              <xsl:choose>
                <xsl:when test="doap:bug-database/@*">
                  <xsl:apply-templates select="doap:bug-database/@*" />
                </xsl:when>
                <xsl:otherwise>
                       None Defined
                     </xsl:otherwise>
              </xsl:choose>
            </td>
          </tr>
          <tr>
            <td class="left">Wiki</td>
            <td class="right">
              <xsl:choose>
                <xsl:when test="doap:wiki/@*">
                  <xsl:apply-templates select="doap:wiki/@*" />
                </xsl:when>
                <xsl:otherwise>
                       None Defined
                     </xsl:otherwise>
              </xsl:choose>
            </td>
          </tr>
          <tr>
            <td class="left">License</td>
            <td class="right">
              <xsl:choose>
                <xsl:when test="doap:license/@rdf:resource = 'http://usefulinc.com/doap/licenses/asl20'"><a href="http://www.apache.org/licenses/LICENSE-2.0">Apache License Version 2.0</a>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:choose>
                    <xsl:when test="doap:license/@*">
                      <xsl:apply-templates select="doap:license/@*" />
                    </xsl:when>
                    <xsl:otherwise>
                           None Defined
                         </xsl:otherwise>
                  </xsl:choose>
                </xsl:otherwise>
              </xsl:choose>
            </td>
          </tr>
          <tr>
            <td class="left">Project Website</td>
            <td class="right">
              <xsl:choose>
                <xsl:when test="doap:homepage/@*">
                  <xsl:apply-templates select="doap:homepage/@*" />
                </xsl:when>
                <xsl:otherwise>
                       None Defined
                     </xsl:otherwise>
              </xsl:choose>
            </td>
          </tr>
          <tr>
            <td class="left">RSS Feeds</td>
            <td class="right">
              <xsl:choose>
                <xsl:when test="foaf:seeAlso">
                  <xsl:apply-templates select="foaf:seeAlso" />
                </xsl:when>
                <xsl:otherwise>
                       None Defined
                     </xsl:otherwise>
              </xsl:choose>
            </td>
          </tr>
        </table>
      </div>
    </section>
  </xsl:template>
  <xsl:template name="project-scm">
    <div class="content">
      <xsl:choose>
        <xsl:when test="doap:repository">
          <xsl:for-each select="doap:repository/doap:SVNRepository">
            <table>
              <tr>
                <td class="left">Browse</td>
                <td class="right">
                  <xsl:apply-templates select="doap:browse/@*" />
                </td>
              </tr>
              <tr>
                <td class="left">Checkout</td>
                <td class="right">
                  <pre>svn co <xsl:apply-templates select="doap:location/@rdf:resource" /></pre>
                </td>
              </tr>
            </table>
          </xsl:for-each>
        </xsl:when>
        <xsl:otherwise>
          <p>
            No source control information provided.
          </p>
        </xsl:otherwise>
      </xsl:choose>
    </div>
  </xsl:template>
  <xsl:template match="doap:release/doap:Version">
    <tr>
      <td class="title">
        <xsl:value-of select="doap:name" />
      </td>
      <td class="right">
        <xsl:value-of  select="doap:revision" />
      </td>
      <td class="right">
        <xsl:value-of  select="doap:created" />
      </td>
    </tr>
  </xsl:template>
  <xsl:template name="project-releases">
    <section>
      <title>Source and Releases</title>
      <div class="content">
        <xsl:choose>
          <xsl:when test="doap:doanload-page">
            <p>
              Releases can be downloaded from
              <xsl:apply-templates select="doap:download-page/@*" />
              .
            </p>
          </xsl:when>
          <xsl:otherwise>
            <p>
              No release download page available.
            </p>
          </xsl:otherwise>
        </xsl:choose>
      </div>
      <xsl:choose>
        <xsl:when test="doap:release">
          <p>
            Most recent releases:
          </p>
          <div class="content">
            <table>
              <tr>
                <td>Release</td>
                <td>Version</td>
                <td>Date</td>
              </tr>
              <xsl:apply-templates select="doap:release/doap:Version" />
            </table>
          </div>
        </xsl:when>
        <xsl:otherwise>
          <p>
            No known current releases.
          </p>
        </xsl:otherwise>
      </xsl:choose>
      <p>
        Access to the source code:
      </p>
      <xsl:call-template name="project-scm" />
    </section>
  </xsl:template>
  
  <xsl:template name="project-contributors">
    <section>
      <title>Contributors</title>
      <xsl:choose>
        <xsl:when test="doap:maintainer">
          <note>This list may not be exhaustive.</note>
          <table>
            <tr>
              <th>Name</th>
              <th>Email</th>
            </tr>
            <xsl:for-each select="doap:maintainer">
                <tr>
                  <td><xsl:apply-templates select="foaf:Person/foaf:name"/></td>
                  <td><xsl:apply-templates select="foaf:Person/foaf:mbox/@rdf:resource"/></td>
                </tr>
            </xsl:for-each>
          </table>
        </xsl:when>
        <xsl:otherwise>
          <p>Contributor data not available.</p>
        </xsl:otherwise>
      </xsl:choose>
    </section>
  </xsl:template>
  
  <xsl:template match="foaf:name">
    <xsl:value-of select="normalize-space(.)"/>
  </xsl:template>
</xsl:stylesheet>
