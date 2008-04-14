#
#--
# Copyright (c) 2008, John Mettraux, OpenWFE.org
# All rights reserved.
# 
# Redistribution and use in source and binary forms, with or without 
# modification, are permitted provided that the following conditions are met:
# 
# . Redistributions of source code must retain the above copyright notice, this
#   list of conditions and the following disclaimer.  
# 
# . Redistributions in binary form must reproduce the above copyright notice, 
#   this list of conditions and the following disclaimer in the documentation 
#   and/or other materials provided with the distribution.
# 
# . Neither the name of the "OpenWFE" nor the names of its contributors may be
#   used to endorse or promote products derived from this software without
#   specific prior written permission.
# 
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" 
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE 
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE 
# ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE 
# LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR 
# CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF 
# SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS 
# INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN 
# CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) 
# ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE 
# POSSIBILITY OF SUCH DAMAGE.
#++
#

#
# "made in Japan"
#
# John Mettraux at openwfe.org
#


#
# IN

#
# OUT

def render_expressions_xml (es)

    builder do |xml|
        xml.instruct!
        xml.expressions :count => es.size do
            es.each do |fexp|
                _render_expression_xml xml, fexp
            end
        end
    end
end

def render_expression_xml (e)

    builder do |xml|
        xml.instruct!
        _render_expression_xml xml, e, true
    end
end

def _render_expression_xml (xml, e, detailed=false)

    params = {}

    params[:link] = request.link(
        :expressions, e.fei.wfid, swapdots(e.fei.expid)) unless detailed

    xml.expression params do

        xml.tag! "class", e.class.name
        xml.name e.fei.expression_name
        xml.apply_time OpenWFE::Xml.to_httpdate(e.apply_time)

        if detailed

            OpenWFE::Xml._fei_to_xml(xml, e.fei)

            xml.parent(
                e.parent_id.to_s, 
                :link => request.link(
                    :expressions, e.parent_id.wfid, swapdots(e.parent_id.expid)))

            xml.children do
                e.children.each do |c|
                    xml.child(
                        c.to_s, :link => request.link(
                            :expressions, c.wfid, swapdots(c.expid)))
                end
            end
        else
            xml.fei e.fei.to_s
        end
    end
end

