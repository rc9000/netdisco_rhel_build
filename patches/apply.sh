#!/bin/bash

patch ../nd2/lib/perl5/App/Netdisco/DB/Result/NodeIpL3device.pm     01_db_result.patch
patch ../nd2/lib/perl5/App/Netdisco/Util/Node.pm                    02_util_node.patch
patch ../nd2/lib/perl5/App/Netdisco/Worker/Plugin/Arpnip/Nodes.pm   03_plugin_arpnip_nodes.patch
