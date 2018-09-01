<?php
require_once("Conexion.php");

class Data{
    private $con;
    
    public function __construct() {
        $this->con = new Conexion();
    }
    
    private function ejecutar($query){
        $this->con->conectar();
        $this->con->ejecutar($query);
        $this->con->desconectar();
    }

    private function ejecutarSelect($query){
        $lista = array();
        
        $this->con->conectar();
        $rs = $this->con->ejecutar($query);
        
        while($ob = $rs->fetch_object()){
            array_push($lista, $ob);
        }
        
        $this->con->desconectar();
    
        return $lista;
    }

    /*
    $mes = mes de inicio de exámenes
    $anio = año de inicio de exámenes
    */
    public function getExamenes($mes, $anio){
        $query = "CALL getExamenes($mes, $anio)";
        
        return $this->ejecutarSelect($query);
    }

    public function getRamos(){
        return $this->ejecutarSelect("CALL getRamos()");
    }

    public function getExamen($mes, $anio, $idRamo){
        $query = "CALL getExamen($mes, $anio, $idRamo)";
        
        return $this->ejecutarSelect($query);
    }

    public function addInfo($info){
        $query = "INSERT INTO info 
        VALUES(NULL, '$info->user_agent','$info->remote_addr',
        '$info->request_method','$info->query_string',NOW());";
        
        $this->ejecutar($query);
    }
}
?>