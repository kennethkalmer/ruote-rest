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


helpers do

#
# ERRORS

  def render_errors_xml (errors)

    builder do |xml|
      xml.instruct!
      xml.errors :count => errors.size do
        errors.each { |error| _render_error_xml xml, error }
      end
    end
  end

  def _render_error_xml (xml, error)

    xml.error do
      #xml.raw error.inspect
      xml.link error.error_id
      xml.wfid error.fei.wfid
      xml.fei error.fei
      xml.call error.message.to_s
      xml.date error.date
      xml.text error.stacktrace.split("\n").first
    end
  end

  def render_error_xml (error)

    builder do |xml|
      xml.instruct!
      _render_error_xml xml, error
    end
  end

  def render_errors_html (errors)

    @errors = errors

    _erb :errors, :layout => :html
  end

  def render_error_html (error, alone=true)

    @error = error
    @alone = alone

    _erb :error, :layout => alone ? :html : false
  end

end
