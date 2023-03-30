import logging as log
class ReadConfig(object):
    def read_config(self):
        config_file = open("/usr/local/callisto/etc/callisto_conf.cfg", 'r')
        case = ""
        lines = config_file.readlines()
        for line in lines:
            if "callisto-conf-allegro" in line:
                case = "allegro"
            if "callisto-conf-ontologies" in line:
                case = "ontologies"
            if "callisto-conf-generic" in line:
                case = "generic"
            if "callisto-conf-dataverse" in line:
                case = "dataverse"
            if "callisto-conf-portal" in line:
                case = "portal"
            #log.debug("case="+case)
                    
            if "host = " in line and case == "allegro":
                self.host = str(line.split("host = ")[1].replace("\n",""))
                log.debug("host="+str(self.host)+".")
            if "port = " in line and case == "allegro":
                self.port = str(line.split("port = ")[1].replace("\n",""))
                log.debug("port="+str(self.port)+".")
            if "user = " in line and case == "allegro":
                self.user = str(line.split("user = ")[1].replace("\n",""))
                log.debug("user="+str(self.user)+".")
            if "password = " in line and case == "allegro":
                self.password = str(line.split("password = ")[1].replace("\n",""))
                log.debug("password="+str(self.password)+".")

            if "close_enough" in line and case == "generic":
                self.close_enough = float(line.split("close_enough = ")[1].replace("\n",""))
                log.debug("close_enough="+str(self.close_enough)+".")

            if "root_iri = " in line and case == "ontologies":
                self.rootiri = str(line.split("root_iri = ")[1].replace("\n",""))
            if "root_https = " in line and case == "ontologies":
                self.roothttps = str(line.split("root_https = ")[1].replace("\n",""))

            if "host_port = "  in line and case == "dataverse":
                self.dataport = str(line.split("host_port = ")[1].replace("\n",""))
            if "host_url = "  in line and case == "dataverse":
                self.dataurl = str(line.split("host_url = ")[1].replace("\n",""))
            
            if "host = " in line and case == "portal":
                self.portalhost = str(line.split("host = ")[1].replace("\n",""))
            if "logs = " in line and case == "portal":
                self.portalog = str(line.split("logs = ")[1].replace("\n",""))
            if "html = " in line and case == "portal":
                self.portalhtml = str(line.split("html = ")[1].replace("\n",""))
            if "temp = " in line and case == "portal":
                self.portaltemp = str(line.split("temp = ")[1].replace("\n",""))

    def __init__(self):
        self.read_config()
