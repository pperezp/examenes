<!DOCTYPE html>
<?php
define("TITULO", "primer semestre");
define("ANIO", "2018");
define("MES", "7");
?>

<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <title>Fecha de exámenes </title>
    </head>
    <body>
        <hr>
        <h1>Fecha exámenes <?php echo TITULO." de ".ANIO;?> </h1>
        
        <?php
        require_once("model/Data.php");

        $d = new Data();

        echo "<form action='index.php' method='post'>";
            echo "<select name='ramo'>";
                echo "<option value='0'>TODOS</option>";
            foreach ($d->getRamos() as $r) {
                echo "<option value='$r->id'>$r->nombre</option>";
            }
            echo "</select>";

            echo "<input type='submit' value='Buscar'>";
        echo "</form>";

        if(isset($_POST["ramo"])){
            $idRamo = $_POST["ramo"];

            if($idRamo == 0){
                $lista = $d->getExamenes(MES,ANIO);
            }else{
                $lista = $d->getExamen(MES,ANIO, $idRamo);
            }

            foreach ($lista as $e) {
                echo "<hr>";
                echo "<h3>$e->Ramo</h3>";
                echo "<h4>$e->Fecha</h4>";
                echo $e->Detalle;
            }
            echo "<hr>";
        }else{
            require_once("model/Info.php");

            $i = new Info();

            $i->user_agent      = $_SERVER["HTTP_USER_AGENT"];
            $i->remote_addr     = $_SERVER["REMOTE_ADDR"];
            $i->request_method  = $_SERVER["REQUEST_METHOD"];
            $i->query_string    = $_SERVER["QUERY_STRING"];
            
            $d->addInfo($i);
        }
        ?>
    </body>
</html>