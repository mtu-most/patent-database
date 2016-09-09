<?php
    function paginate($reload, $page, $tpages) {
        $adjacents = 2;
        //$prevlabel = "&lsaquo; Prev";
        //$nextlabel = "Next &rsaquo;";
        $prevlabel = "&lsaquo;";
        $nextlabel = "&rsaquo;";
        $out = "";
        //first
        if ($page>2) {
            //$out.= "<a style='font-size:11px' href=\"" . $reload."&amp;page=".$tpages."\">" .$tpages."</a>\n";
            $out.= "<li><a href=\"" . $reload."&amp;page=1\">".$prevlabel.$prevlabel."</a>\n</li>";
        }
        //else {
        //		$out.= "<li><span>".$prevlabel.$prevlabel."</span>\n</li>";
        //	}
        // previous
        if ($page == 1) {
            //$out.= "<li><span>".$prevlabel."</span>\n</li>";
        } elseif ($page == 2) {
            $out.="<li><a href=\"".$reload."\">".$prevlabel."</a>\n</li>";
        } else {
            $out.="<li><a href=\"".$reload."&amp;page=".($page - 1)."\">".$prevlabel."</a>\n</li>";
        }
        $pmin=($page>$adjacents)?($page - $adjacents):1;
        $pmax=($page<($tpages - $adjacents))?($page + $adjacents):$tpages;
        for ($i = $pmin; $i <= $pmax; $i++) {
            if ($i == $page) {
                //$out.= "<li class=\"active\"><a href=\"".$reload."\">".$i."</a></li>\n";
                $out.= "<li class=\"active\"><a>".$i."</a></li>\n";
            } elseif ($i == 1) {
                $out.= "<li><a href=\"".$reload. "&amp;page=".$i."\">".$i."</a>\n</li>";
            } else {
                $out.= "<li><a href=\"".$reload. "&amp;page=".$i."\">".$i. "</a>\n</li>";
            }
        }
        
       
        // next
        if ($page < $tpages) {
            $out.= "<li><a href=\"".$reload."&amp;page=".($page + 1)."\">".$nextlabel."</a>\n</li>";
        } else {
            $out.= "<span style='font-size:11px'>".$nextlabel."</span>\n";
        }
        //last
        if ($page<($tpages - $adjacents)) {
            //$out.= "<a style='font-size:11px' href=\"" . $reload."&amp;page=".$tpages."\">" .$tpages."</a>\n";
            $out.= "<li><a href=\"" . $reload."&amp;page=".$tpages."\">".$nextlabel.$nextlabel."</a>\n</li>";
        }
        $out.= "";
        return $out;
    }
    ?>