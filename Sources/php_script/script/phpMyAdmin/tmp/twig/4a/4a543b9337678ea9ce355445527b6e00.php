<?php

use Twig\Environment;
use Twig\Error\LoaderError;
use Twig\Error\RuntimeError;
use Twig\Extension\SandboxExtension;
use Twig\Markup;
use Twig\Sandbox\SecurityError;
use Twig\Sandbox\SecurityNotAllowedTagError;
use Twig\Sandbox\SecurityNotAllowedFilterError;
use Twig\Sandbox\SecurityNotAllowedFunctionError;
use Twig\Source;
use Twig\Template;

/* error/report_form.twig */
class __TwigTemplate_42cfeae41ac5f38a7b29a68247d0b226 extends Template
{
    private $source;
    private $macros = [];

    public function __construct(Environment $env)
    {
        parent::__construct($env);

        $this->source = $this->getSourceContext();

        $this->parent = false;

        $this->blocks = [
        ];
    }

    protected function doDisplay(array $context, array $blocks = [])
    {
        $macros = $this->macros;
        // line 1
        if (($context["allowed_to_send_error_reports"] ?? null)) {
            // line 2
            echo "<p>
  ";
echo _gettext("This report automatically includes data about the error and information about relevant configuration settings. It will be sent to the phpMyAdmin team for debugging the error.");
            // line 6
            echo "</p>
<form action=\"";
            // line 7
            echo PhpMyAdmin\Url::getFromRoute("/error-report");
            echo "\" method=\"post\" id=\"errorReportForm\" class=\"ajax\">
  <div class=\"mb-3\">
    <label for=\"errorReportDescription\">
      <strong>
        ";
echo _gettext("Can you tell us the steps leading to this error? It decisively helps in debugging:");
            // line 12
            echo "      </strong>
    </label>
    <textarea class=\"form-control\" name=\"description\" id=\"errorReportDescription\"></textarea>
  </div>

  <div class=\"mb-3\">
    ";
echo _gettext("You may examine the data in the error report:");
            // line 19
            echo "    <pre class=\"pre-scrollable\">";
            echo twig_escape_filter($this->env, json_encode(($context["report_data"] ?? null), (twig_constant("JSON_PRETTY_PRINT") | twig_constant("JSON_UNESCAPED_SLASHES"))), "html", null, true);
            echo "</pre>
  </div>

  <div class=\"form-check\">
    <input class=\"form-check-input\" type=\"checkbox\" name=\"always_send\" id=\"errorReportAlwaysSendCheckbox\">
    <label class=\"form-check-label\" for=\"errorReportAlwaysSendCheckbox\">
      ";
echo _gettext("Automatically send report next time");
            // line 26
            echo "    </label>
  </div>

  ";
            // line 29
            echo ($context["hidden_inputs"] ?? null);
            echo "
  ";
            // line 30
            echo ($context["hidden_fields"] ?? null);
            echo "
</form>
";
        } else {
            // line 33
            echo "<div class=\"mb-3\">
  <pre class=\"pre-scrollable\">";
            // line 34
            echo twig_escape_filter($this->env, json_encode(($context["report_data"] ?? null), (twig_constant("JSON_PRETTY_PRINT") | twig_constant("JSON_UNESCAPED_SLASHES"))), "html", null, true);
            echo "</pre>
</div>
";
        }
    }

    public function getTemplateName()
    {
        return "error/report_form.twig";
    }

    public function isTraitable()
    {
        return false;
    }

    public function getDebugInfo()
    {
        return array (  92 => 34,  89 => 33,  83 => 30,  79 => 29,  74 => 26,  63 => 19,  54 => 12,  46 => 7,  43 => 6,  39 => 2,  37 => 1,);
    }

    public function getSourceContext()
    {
        return new Source("", "error/report_form.twig", "C:\\xampp\\phpMyAdmin\\templates\\error\\report_form.twig");
    }
}
