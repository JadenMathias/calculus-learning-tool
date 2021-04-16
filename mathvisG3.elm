-- THIS CODE ONLY RUNS ON MACOUTREACH GAME SLOT--
import Html exposing(Html)
import Html.Attributes exposing(src)

myShapes model =
    case model.state of
        Menu  ->
            [ -- remove whatever was initially in there and Add the following --
              menucontent,
              menubutton "Integral Help"   |> move (0,25)  |> scale (model.b1) |> notifyMouseDown B1Down |> notifyMouseUp IHStart,
              menubutton "Derivative Help" |> scale (model.b2) |> notifyMouseDown B2Down |> notifyMouseUp DHStart,
              menubutton "Integral Game"   |> move(0,-25)  |>scale (model.b3)  |> notifyMouseDown B3Down |> notifyMouseUp IGStart,
              menubutton "Derivative Game" |> move (0,-50) |>scale (model.b4)   |> notifyMouseDown B4Down |> notifyMouseUp DGStart
            ]
        IntegralHelp  ->
            [ square 200
                  |> filled (rgb 0 188 212),
              text "What is Integral?"
                   |>centered
                   |>filled white
                   |> move (0,30)
                   |> scale 1.5
              , integralmenubutton"Definition" |> move(0,15) |> notifyTap IHS1T
              , integralmenubutton"Common Functions Integral" |> move(0,-5) |> notifyTap IHS2T
              , integralmenubutton"Useful Rules"|> move(0,-25) |> notifyTap IHS4T
              , integralmenubutton "2 Special Ways to Integral"|>move(0,-45) |> notifyTap IHS7T
              , exitbutton |> move (-83,-57) |>notifyTap IHBack
            ]
        DerivativeHelp  ->
            [ square 200
                  |> filled (rgb 0 188 212),
              fancytext "Derivative Menu" Red
                  |> move (0,35),
              derivativemenubutton "Help Start" |> move(0,15) |> notifyTap DHS1T,
              derivativemenubutton "Common Derivatives" |> move(0,-5) |> notifyTap DHS11Shortcut,
              derivativemenubutton "Derivative Rules" |> move(0,-25) |> notifyTap DHS12Shortcut,
              exitbutton |> move (0,-50) |>notifyTap DHBack
            ]
        IntegralGame  ->
            [ 
              howtoIntegral,
              exitbutton |> move (0,-50) |>notifyTap IGExit
            ]
            
                      
        DerivativeGame  -> [ howtoDerivative, exitbutton |> move (0,-50) |>notifyTap DGExit]
                       
            
        IGQ1  ->
            if model.score >= 5 
              then [gameComplete "integral"|> notifyTap IGExit |> notifyTap Reset]
            
              else let question = (case (remainderBy 10 (floor model.otherTime) ) of 
                                      1 -> q1i
                                      2 -> q2i
                                      3 -> q3i
                                      4 -> q4i 
                                      5 -> q5i
                                      6 -> q6i
                                      7 -> q7i
                                      8 -> q8i
                                      9 -> q9i
                                      _ -> q10i
                                       ) in
                      
                            [rectangle 200 200 |> filled (rgb 0 188 212),
                             menubutton ("Score: "++ (Debug.toString model.score)) |> scale 0.7 |> move (70,50),
                             menubutton "Menu" |> scale 0.7 |> move (-85,50) |> notifyTap IGExit,
                             text question.formula |> centered |> filled black |> scale 0.7 |> move (0,20),
                             group [group [roundedRect 24 20 3|> filled (rgb 255 160 0), text question.correctA |> centered |> filled white |> scale 0.35] |> move question.cap |> notifyTap NewQWin,
                             group [roundedRect 24 20 3|> filled (rgb 255 160 0), text question.a1 |> centered  |> filled white |> scale 0.35] |> move question.a1p |> notifyTap NewQLose,
                             group [roundedRect 24 20 3|> filled (rgb 255 160 0), text question.a2 |> centered  |> filled white |> scale 0.35] |> move question.a2p |> notifyTap NewQLose,
                             group [roundedRect 24 20 3|> filled (rgb 255 160 0), text question.a3 |> centered  |> filled white |> scale 0.35] |> move question.a3p |> notifyTap NewQLose] |> move (0,-20)]

        IGQ2  ->
            [ text "IGQ2"
                  |> centered
                  |> filled black
            ]
        IGQ3  ->
            [ text "IGQ3"
                  |> centered
                  |> filled black
            ]
        IGQ4  ->
            [ text "IGQ4"
                  |> centered
                  |> filled black
            ]
        IGQ5  ->
            [ text "IGQ5"
                  |> centered
                  |> filled black
            ]
        DGQ1  ->
            [qDContent model q1d
            ]
        DGQ2  ->
            [ qDContent model q2d
            ]
        DGQ3  ->
            [ qDContent model q3d
            ]
        DGQ4  ->
            [ completedD model
            ]
        DGQ5  ->
            [ text "DGQ5"
                  |> centered
                  |> filled black
            ]
        IHS1  ->
            [ square 200
                  |> filled (rgb 0 188 212)
              ,fancytext "What is integral?" Purple
                  |> scale 0.45
                  |> move (-58,50)
            
              ,text " Integration can be used to find areas,"
                  |> alignRight
                  |> bold
                  |> size 5
                  |> filled black
                  |> move(5,30)
              ,text "volumes,central points and many"
                  |> alignRight
                  |> bold
                  |> size 5
                  |> filled black
                  |> move(85,30)
              ,text "useful things. But it is often used to find"
                  |> alignRight
                  |> bold
                  |> size 5
                  |> filled black
                  |> move(18,20)
              ,text "the area underneath the "
                  |> alignRight
                  |> bold
                  |> size 5
                  |> filled black
                  |> move(85,20)
              ,text "graph of a function like this:"
                  |> alignRight
                  |> bold
                  |> size 5
                  |> filled black
                  |> move(-15,10)
              ,pic1
              ,integralmenubutton"Back" |> move(-70,-55) |> notifyTap IHS1B
              ,integralmenubutton"Menu" |> move(78,52) |> notifyTap IHB
              ,integralmenubutton"Next"|> move(78,-55) |> notifyTap S1S2
               
            ]
        IHS2  ->
            [ 
            square 200
                  |> filled (rgb 0 188 212)
            ,fancytext "Common" Purple
              |>scale 0.3
              |>move(-70,40)
            ,fancytext "Functions" Purple
              |>scale 0.3
              |>move(-70,30)
            ,fancytext "Integral" Purple
              |>scale 0.3
              |>move(-70,20)
            ,triangle 10
              |> filled purple
              |> scale 0.5
              |> move(-60,0)
            ,rect 15 10
              |> filled purple
              |> scale 0.5
              |> move(-65,0)
            ,pic2
            ,integralmenubutton"Back" |> move(-70,-55) |> notifyTap S2S1
            ,integralmenubutton"Menu" |> move(80,52) |> notifyTap IHB
            ,integralmenubutton"Next"|> move(80,-55) |> notifyTap S2S3
             
            ]
        IHS3  ->
            [ 
             square 200
                  |> filled (rgb 0 188 212)
            ,fancytext "Infinite Integral vs Definite Integral" Purple
              |> scale 0.3
              |> move(-10,50)
           
            ,text " A Definite Integral has actual values to"
                  |> alignRight
                  |> bold
                  |> size 5
                  |> filled black
                  |> move(5,30)
             ,text "calculate between:"
                  |> alignRight
                  |> bold
                  |> size 5
                  |> filled black
                  |> move(55,30)
            ,fancytext "Indefinite Integral" Purple
              |> scale 0.3
              |> move(-30,-50)
            ,fancytext "Definite Integral" Purple
              |> scale 0.3
              |> move(40,-50)
            ,pic3in
            ,pic3de
            ,integralmenubutton"Back" |> move(-70,-55) |> notifyTap S3S2
            ,integralmenubutton"Menu" |> move(80,52) |> notifyTap IHB
            ,integralmenubutton"Next"|> move(80,-55) |> notifyTap S3S4
            ]
        IHS4  ->
            [ 
              square 200
                  |> filled (rgb 0 188 212)
              ,rect 128 90
                  |> filled lightGray
                  |> move(5,10)
              ,fancytext "Some" Purple
              |>scale 0.3
              |>move(-75,40)
              ,fancytext "(Definite)" Purple
              |>scale 0.3
              |>move(-75,30)
              ,fancytext "Integral" Purple
              |>scale 0.3
              |>move(-75,20)
              ,fancytext "Rules" Purple
              |>scale 0.3
              |>move(-75,10)
              ,triangle 10
              |> filled purple
              |> scale 0.5
              |> move(-70,0)
              ,rect 15 10
              |> filled purple
              |> scale 0.5
              |> move(-75,0)
              ,pic4
              ,fancytext "Note: Common Functions Integral can be used on both Indefinite and Definite Integral" Purple
              |>scale 0.2
              |>move(0,-40)
              ,integralmenubutton"Back" |> move(-70,-55) |> notifyTap S4S3
              ,integralmenubutton"Menu" |> move(80,52) |> notifyTap IHB
              ,integralmenubutton"Next"|> move(80,-55) |> notifyTap S4S5
            ]
        IHS5  ->
            [
            square 200
                  |> filled (rgb 0 188 212)
            ,rect 100 120
                  |> filled lightGray
                  |> move(0,0)
            ,fancytext "Example" Purple
              |>scale 0.4
              |>move(0,50)
            ,fancytext "What is ∫8x + 4x^3- 6x^2 dx?" Purple
              |>scale 0.3
              |>move(0,40)
            ,fancytext "By Sum and Difference Rule:" Purple
              |>scale 0.2
              |>move(0,30)
            ,fancytext "=∫8x dx + ∫4x^3 dx − ∫6x^2dx" Purple
              |>scale 0.2
              |>move(0,20)
            ,fancytext "By Constant Rule:" Purple
              |>scale 0.2
              |>move(0,10)
            ,fancytext "= 8∫x dx + 4∫x^3 dx − 6∫x^2 dx" Purple
              |>scale 0.2
              |>move(0,0)
            ,fancytext "By Power Rule:" Purple
              |>scale 0.2
              |>move(0,-10)
            ,fancytext "= 8*(x^2)/2 + 4*(x^4)/4 − 6*(x^3)/3 + C" Purple
              |>scale 0.2
              |>move(0,-20)
            ,fancytext "Simplify:" Purple
              |>scale 0.2
              |>move(0,-30)
            ,fancytext "= 4*x^2 + x^4 − 2*x^3 + C" Purple
              |>scale 0.2
              |>move(0,-40)
            
            
            ,integralmenubutton"Back" |> move(-70,-55) |> notifyTap S5S4
            ,integralmenubutton"Menu" |> move(80,52) |> notifyTap IHB
            ,integralmenubutton"Next"|> move(80,-55) |> notifyTap S5S6
            ]
        IHS6  ->
            [
            square 200
                  |> filled (rgb 0 188 212)
            ,rect 170 90
                  |> filled lightGray
                  |> move(0,-5)      
            ,fancytext "What is +C in the answer?" Purple
              |>scale 0.4
              |>move(0,50)
            ,fancytext "It is the Constant of Integration" Purple
              |>scale 0.3
              |>move(-40,30)
            ,fancytext "For example:" Purple
              |>scale 0.2
              |>move(-65,25)
            ,pic5 
            ,fancytext "Because all the functions whose derivative is 2x can't be distinguished if we don't add C" Purple
              |>scale 0.2
              |>move(0,-5)
            ,pic5add
            ,fancytext "When we find the integral, we only know 2x, but there may exist a constant of any value" Purple
              |>scale 0.2
              |>move(0,-40)
            ,fancytext "So we write +C at the end" Purple
              |>scale 0.2
              |>move(0,-45)
              
            ,integralmenubutton"Back" |> move(-70,-55) |> notifyTap S6S5
            ,integralmenubutton"Menu" |> move(80,52) |> notifyTap IHB
            ,integralmenubutton"Next"|> move(80,-55) |> notifyTap S6S7
            ]
        IHS7  ->
            [
            square 200
                  |> filled (rgb 0 188 212)
            ,rect 170 90
                  |> filled lightGray
                  |> move(0,-5)      
            ,fancytext "Integration by Parts" Purple
              |>scale 0.4
              |>move(0,50)
            ,fancytext "This is a method of integration that is useful when two functions are multiplied together" Purple
              |>scale 0.2
              |>move(0,30)
            ,pic6
            ,fancytext "u is the function u(x)" Purple
              |>scale 0.2
              |>move(50,-10)
            ,fancytext "v is the function v(x)" Purple
              |>scale 0.2
              |>move(50,-15)
            ,fancytext "u' is the derivative of the function u(x)" Purple
              |>scale 0.2
              |>move(40,-30)  
            ,integralmenubutton"Back" |> move(-70,-55) |> notifyTap S7S6
            ,integralmenubutton"Menu" |> move(80,52) |> notifyTap IHB
            ,integralmenubutton"Next"|> move(80,-55) |> notifyTap S7S8
            ]
        IHS8  ->
            [
            square 200
                  |> filled (rgb 0 188 212)
            ,fancytext "Example" Purple
              |>scale 0.4
              |>move(0,50)
            ,pic7
            ,integralmenubutton"Back" |> move(-70,-55) |> notifyTap S8S7
            ,integralmenubutton"Menu" |> move(80,52) |> notifyTap IHB
            ,integralmenubutton"Next"|> move(80,-55) |> notifyTap S8S9
            ]
        IHS9  ->
            [
            square 200
                  |> filled (rgb 0 188 212)
            ,rect 170 90
                  |> filled lightGray
                  |> move(0,-5)      
            ,fancytext "Integration by Substitution" Purple
              |>scale 0.4
              |>move(0,50)
            ,fancytext "Integration by Substitution is a way to find an integral when it is set up in a special way." Purple
              |>scale 0.2
              |>move(0,30)
            ,fancytext "Make sure the integral can be written in this form:" Purple
              |>scale 0.2
              |>move(-35,25)
            ,pic81
            ,fancytext "Then we can do the substitution:" Purple
              |>scale 0.2
              |>move(-52,0)
            ,pic82
            ,fancytext "Then we can set u =g(x) and integrate ∫f(u) du " Purple
              |>scale 0.2
              |>move(-40,-35)
            ,fancytext "Finally re-inserting g(x) where u is" Purple
              |>scale 0.2
              |>move(-51,-40)
            ,integralmenubutton"Back" |> move(-70,-55) |> notifyTap S9S8
            ,integralmenubutton"Menu" |> move(80,52) |> notifyTap IHB
            ,integralmenubutton"Next"|> move(80,-55) |> notifyTap S9S10
            ]
        IHS10 ->
            [
            square 200
                  |> filled (rgb 0 188 212)
            ,rect 170 90
                  |> filled lightGray
                  |> move(0,-5)      
            ,fancytext "Example" Purple
              |>scale 0.4
              |>move(0,50)
            ,fancytext "∫(5x+2)^7 dx" Purple
              |>scale 0.4
              |>move(-60,30)
            ,fancytext "make it in this form:" Purple
              |>scale 0.3
              |>move(-55,20)
            ,fancytext "(1/5)*∫(5x+2)^7 * 5 dx" Purple
              |>scale 0.3
              |>move(5,20)
            ,fancytext "Then, by substitution:" Purple
              |>scale 0.3
              |>move(-52,10)
            ,pic9
            ,fancytext "Then, integrate it: =(1/5) * (u^8/8) +C" Purple
              |>scale 0.3
              |>move(-32,-30)  
            ,fancytext "Put u=5x+2 back, = (5x+2)^8/40 +C" Purple
              |>scale 0.3
              |>move(-32,-40)
            ,integralmenubutton"Back" |> move(-70,-55) |> notifyTap S10S9
            ,integralmenubutton"Menu"|> move(80,52) |> notifyTap  IHS10B
            ]
        DHS1  ->
            [ square 200
                  |> filled (rgb 0 188 212)
              ,text "What is a derivative?"
                  |> centered
                  |> bold 
                  |> size 15
                  |> filled white
                  |> move (-20,47)
              ,text "The derivative of a function gives you the slope of the original function at any x value."
                  |> centered
                  |> bold 
                  |> size 5 
                  |> filled white
                  |> move (0,30)
              ,text "By substituting x in the derivative, you can find "
                  |> centered
                  |> bold 
                  |> size 5 
                  |> filled white
                  |> move (-40,25)
              ,text "the slope of the original function at that x value."
                  |> centered
                  |> bold 
                  |> size 5 
                  |> filled white
                  |> move (-40,20)
              ,derivativePic
              ,derivativemenubutton"Back" |> move(-70,-55) |> notifyTap DHS1B
              ,derivativemenubutton"Next"|> move(80,-55) |> notifyTap DHS2T
              ,derivativemenubutton"Menu"|> move(80,50) |> notifyTap DHS1M
            ]
        DHS2  ->
            [ square 200
                  |> filled (rgb 0 188 212)
              ,text "Definition"
                  |> centered
                  |> bold 
                  |> size 15
                  |> filled white
                  |> move (-50,47)
              ,text "The derivative of a function can be stated with the following formula: "
                  |> centered
                  |> bold 
                  |> size 5
                  |> filled white
                  |> move (-10,35)    
              ,text "f'(x) = lim"
                  |> centered
                  |> bold 
                  |> size 8 
                  |> filled white
                  |> move (-60,20)
              ,text "h -> 0"
                  |> centered
                  |> bold 
                  |> size 4
                  |> filled white
                  |> move (-48,16)
              ,text "f(x+h) - f(x)"
                  |> centered
                  |> bold 
                  |> size 8 
                  |> filled white
                  |> move (-18,22)
              ,text "h"
                  |> centered
                  |> bold 
                  |> size 8 
                  |> filled white
                  |> move (-20,12)
              ,rect 40 1
                  |> filled (rgb 255 255 255)
                  |> move (-18,19)
              ,derivativemenubutton"Back" |> move(-70,-55) |> notifyTap DHS2B
              ,derivativemenubutton"Next"|> move(80,-55) |> notifyTap DHS3T
              ,derivativemenubutton"Menu"|> move(80,50) |> notifyTap DHS2M
            ]
        DHS3  ->
            [ square 200
                  |> filled (rgb 0 188 212)
              ,text "Power Rule"
                  |> centered
                  |> bold 
                  |> size 15
                  |> filled white
                  |> move (-50,47)
              ,text "Function"
                  |> bold
                  |> size 5
                  |> filled white
                  |> move (-25,40)
              ,text "Derivative"
                  |> bold
                  |> size 5
                  |> filled white
                  |> move (5,40)
              ,text "x^n"
                  |> bold
                  |> size 5
                  |> filled white
                  |> move (-25,35)
              ,text "nx^(n-1)"
                  |> bold
                  |> size 5
                  |> filled white
                  |> move (5,35)
              ,text "Example: "
                  |> centered
                  |> bold 
                  |> size 8
                  |> filled white
                  |> move (-60,10)
              ,text "d/dx(x^2) = 2 * x^(2 - 1)"
                  |> centered
                  |> bold 
                  |> size 5
                  |> filled white
                  |> move (-10,0)  
              ,text "= 2 * x^1"
                  |> centered
                  |> bold 
                  |> size 5
                  |> filled white
                  |> move (-5,-5)  
              ,text "= 2x"
                  |> centered
                  |> bold 
                  |> size 5
                  |> filled white
                  |> move (-9,-10)
              ,derivativemenubutton"Back" |> move(-70,-55) |> notifyTap DHS3B
              ,derivativemenubutton"Next"|> move(80,-55) |> notifyTap DHS4T
              ,derivativemenubutton"Menu"|> move(80,50) |> notifyTap DHS3M
            ]
        DHS4  ->
            [ square 200
                  |> filled (rgb 0 188 212)
              ,text "Multiplication by a constant"
                  |> centered
                  |> bold 
                  |> size 10
                  |> filled white
                  |> move (-20,47)
              ,text "Function"
                  |> bold
                  |> size 5
                  |> filled white
                  |> move (-25,40)
              ,text "Derivative"
                  |> bold
                  |> size 5
                  |> filled white
                  |> move (5,40)
              ,text "cf"
                  |> bold
                  |> size 5
                  |> filled white
                  |> move (-25,35)
              ,text "cf'"
                  |> bold
                  |> size 5
                  |> filled white
                  |> move (5,35)
              ,text "Example: "
                  |> centered
                  |> bold 
                  |> size 8
                  |> filled white
                  |> move (-60,10)
              ,text "d/dx(3x^2) = 3 * d/dx(x^2)"
                  |> centered
                  |> bold 
                  |> size 5
                  |> filled white
                  |> move (-10,0)  
              ,text "= 3 * 2x"
                  |> centered
                  |> bold 
                  |> size 5
                  |> filled white
                  |> move (-5,-5)  
              ,text "= 6x"
                  |> centered
                  |> bold 
                  |> size 5
                  |> filled white
                  |> move (-9,-10)  
              ,derivativemenubutton"Back" |> move(-70,-55) |> notifyTap DHS4B
              ,derivativemenubutton"Next"|> move(80,-55) |> notifyTap DHS5T
              ,derivativemenubutton"Menu"|> move(80,50) |> notifyTap DHS4M
            ]
        DHS5  ->
            [ square 200
                  |> filled (rgb 0 188 212)
              ,text "Sum Rule"
                  |> centered
                  |> bold 
                  |> size 15
                  |> filled white
                  |> move (-50,47)
              ,text "Function"
                  |> bold
                  |> size 5
                  |> filled white
                  |> move (-25,40)
              ,text "Derivative"
                  |> bold
                  |> size 5
                  |> filled white
                  |> move (5,40)
              ,text "f + g"
                  |> bold
                  |> size 5
                  |> filled white
                  |> move (-25,35)
              ,text "f' + g'"
                  |> bold
                  |> size 5
                  |> filled white
                  |> move (5,35)
              ,text "Example: "
                  |> centered
                  |> bold 
                  |> size 8
                  |> filled white
                  |> move (-60,10)
              ,text "d/dx(x^2 + x^3) = d/dx(x^2) + d/dx(x^3)"
                  |> centered
                  |> bold 
                  |> size 5
                  |> filled white
                  |> move (-10,0)  
              ,text "= 2 * x^(2-1) + 3 * x^(3-1)"
                  |> centered
                  |> bold 
                  |> size 5
                  |> filled white
                  |> move (-5,-5)  
              ,text "= 2x + 3x^2"
                  |> centered
                  |> bold 
                  |> size 5
                  |> filled white
                  |> move (-9,-10)
              ,derivativemenubutton"Back" |> move(-70,-55) |> notifyTap DHS5B
              ,derivativemenubutton"Next"|> move(80,-55) |> notifyTap DHS6T
              ,derivativemenubutton"Menu"|> move(80,50) |> notifyTap DHS5M
            ]
        DHS6  ->
            [ square 200
                  |> filled (rgb 0 188 212)
              ,text "Difference Rule"
                  |> centered
                  |> bold 
                  |> size 15
                  |> filled white
                  |> move (-40,47)
              ,text "Function"
                  |> bold
                  |> size 5
                  |> filled white
                  |> move (-25,40)
              ,text "Derivative"
                  |> bold
                  |> size 5
                  |> filled white
                  |> move (5,40)
              ,text "f - g"
                  |> bold
                  |> size 5
                  |> filled white
                  |> move (-25,35)
              ,text "f' - g'"
                  |> bold
                  |> size 5
                  |> filled white
                  |> move (5,35)
              ,text "Example: "
                  |> centered
                  |> bold 
                  |> size 8
                  |> filled white
                  |> move (-60,10)
              ,text "d/dx(x^2 - x^3) = d/dx(x^2) - d/dx(x^3)"
                  |> centered
                  |> bold 
                  |> size 5
                  |> filled white
                  |> move (-10,0)  
              ,text "= 2 * x^(2-1) - 3 * x^(3-1)"
                  |> centered
                  |> bold 
                  |> size 5
                  |> filled white
                  |> move (-5,-5)  
              ,text "= 2x - 3x^2"
                  |> centered
                  |> bold 
                  |> size 5
                  |> filled white
                  |> move (-9,-10)
              ,derivativemenubutton"Back" |> move(-70,-55) |> notifyTap DHS6B
              ,derivativemenubutton"Next"|> move(80,-55) |> notifyTap DHS7T
              ,derivativemenubutton"Menu"|> move(80,50) |> notifyTap DHS6M
            ]
        DHS7  ->
            [ square 200
                  |> filled (rgb 0 188 212)
              ,text "Product Rule"
                  |> centered
                  |> bold 
                  |> size 15
                  |> filled white
                  |> move (-42,47)
              ,text "Function"
                  |> bold
                  |> size 5
                  |> filled white
                  |> move (-25,40)
              ,text "Derivative"
                  |> bold
                  |> size 5
                  |> filled white
                  |> move (5,40)
              ,text "fg"
                  |> bold
                  |> size 5
                  |> filled white
                  |> move (-25,35)
              ,text "f * g' + f' * g"
                  |> bold
                  |> size 5
                  |> filled white
                  |> move (5,35)
              ,text "Example: "
                  |> centered
                  |> bold 
                  |> size 8
                  |> filled white
                  |> move (-60,10)
              ,text "d/dx(cos(x)*sin(x)) = cos(x)*cos(x) - sin(x)*sin(x)"
                  |> centered
                  |> bold 
                  |> size 5
                  |> filled white
                  |> move (-10,0)  
              ,text "= cos^2(x) - sin^2(x)"
                  |> centered
                  |> bold 
                  |> size 5
                  |> filled white
                  |> move (-5,-5)  
              ,derivativemenubutton"Back" |> move(-70,-55) |> notifyTap DHS7B
              ,derivativemenubutton"Next"|> move(80,-55) |> notifyTap DHS8T
              ,derivativemenubutton"Menu"|> move(80,50) |> notifyTap DHS7M
            ]
        DHS8  ->
            [ square 200
                  |> filled (rgb 0 188 212)
              ,text "Quotient Rule"
                  |> centered
                  |> bold 
                  |> size 15
                  |> filled white
                  |> move (-40,47)
              ,text "Function"
                  |> bold
                  |> size 5
                  |> filled white
                  |> move (-25,40)
              ,text "Derivative"
                  |> bold
                  |> size 5
                  |> filled white
                  |> move (5,40)
              ,text "f/g"
                  |> bold
                  |> size 5
                  |> filled white
                  |> move (-25,35)
              ,text "(f' g - g' f) / g^2"
                  |> bold
                  |> size 5
                  |> filled white
                  |> move (5,35)
              ,text "Example: "
                  |> centered
                  |> bold 
                  |> size 8
                  |> filled white
                  |> move (-60,10)
              ,text "d/dx(cos(x) / x) = (x(-sin(x)) - cos(x)(1)) / x^2"
                  |> centered
                  |> bold 
                  |> size 5
                  |> filled white
                  |> move (-10,0)  
              ,text "= (xsin(x) + cos(x)) / x^2"
                  |> centered
                  |> bold 
                  |> size 5
                  |> filled white
                  |> move (-5,-5)  
              ,derivativemenubutton"Back" |> move(-70,-55) |> notifyTap DHS8B
              ,derivativemenubutton"Next"|> move(80,-55) |> notifyTap DHS9T
              ,derivativemenubutton"Menu"|> move(80,50) |> notifyTap DHS8M
            ]
        DHS9  ->
            [ square 200
                  |> filled (rgb 0 188 212)
              ,text "Reciprocal Rule"
                  |> centered
                  |> bold 
                  |> size 15
                  |> filled white
                  |> move (-40,47)
              ,text "Function"
                  |> bold
                  |> size 5
                  |> filled white
                  |> move (-25,40)
              ,text "Derivative"
                  |> bold
                  |> size 5
                  |> filled white
                  |> move (5,40)
              ,text "1/f"
                  |> bold
                  |> size 5
                  |> filled white
                  |> move (-25,35)
              ,text "-f'/f^2"
                  |> bold
                  |> size 5
                  |> filled white
                  |> move (5,35)
              ,text "Example: "
                  |> centered
                  |> bold 
                  |> size 8
                  |> filled white
                  |> move (-60,10)
              ,text "d/dx(1 / x) = -1 / x^2"
                  |> centered
                  |> bold 
                  |> size 5
                  |> filled white
                  |> move (-10,0)
              ,derivativemenubutton"Back" |> move(-70,-55) |> notifyTap DHS9B
              ,derivativemenubutton"Next"|> move(80,-55) |> notifyTap DHS10T
              ,derivativemenubutton"Menu"|> move(80,50) |> notifyTap DHS9M
            ]
        DHS10  ->
            [ square 200
                  |> filled (rgb 0 188 212)
              ,text "Chain Rule"
                  |> centered
                  |> bold 
                  |> size 15
                  |> filled white
                  |> move (-47,47)
              ,text "Function"
                  |> bold
                  |> size 5
                  |> filled white
                  |> move (-25,40)
              ,text "Derivative"
                  |> bold
                  |> size 5
                  |> filled white
                  |> move (5,40)
              ,text "f ( g(x) )"
                  |> bold
                  |> size 5
                  |> filled white
                  |> move (-25,35)
              ,text "f'( g(x) ) * g'(x)"
                  |> bold
                  |> size 5
                  |> filled white
                  |> move (5,35)
              ,text "Example: "
                  |> centered
                  |> bold 
                  |> size 8
                  |> filled white
                  |> move (-60,10)
              ,text "d/dx(sin(x^2)) = cos(x^2) * 2x"
                  |> centered
                  |> bold 
                  |> size 5
                  |> filled white
                  |> move (-10,0)
              ,derivativemenubutton"Back" |> move(-70,-55) |> notifyTap DHS10B
              ,derivativemenubutton"Next"|> move(80,-55) |> notifyTap DHS11T
              ,derivativemenubutton"Menu"|> move(80,50) |> notifyTap DHS10M
            ]
        DHS11  ->
            [ square 200
                  |> filled (rgb 0 188 212)
              ,text "Common Derivatives"
                  |> centered
                  |> bold 
                  |> size 10 
                  |> filled white
                  |> move (-45,50)
              ,text "d/dx (x) = 1"
                  |> centered
                  |> bold 
                  |> size 5 
                  |> filled white
                  |> move (-30,30)
              ,text "d/dx (sin x) = cos x"
                  |> centered
                  |> bold 
                  |> size 5 
                  |> filled white
                  |> move (-30,25)
              ,text "d/dx (cos x) = -sin x"
                  |> centered
                  |> bold 
                  |> size 5 
                  |> filled white
                  |> move (-30,20)
              ,text "d/dx (tan x) = sec^2 x"
                  |> centered
                  |> bold 
                  |> size 5 
                  |> filled white
                  |> move (-30,15)    
              ,text "d/dx (sec x) = sec x tan x"
                  |> centered
                  |> bold 
                  |> size 5 
                  |> filled white
                  |> move (-30,10)
              ,text "d/dx (csc x) = -csc x cot x"
                  |> centered
                  |> bold 
                  |> size 5 
                  |> filled white
                  |> move (-30,5)    
              ,text "d/dx (cot x) = -csc^2 x"
                  |> centered
                  |> bold 
                  |> size 5 
                  |> filled white
                  |> move (-30,0)
              ,text "d/dx (e^ x) = e^ x"
                  |> centered
                  |> bold 
                  |> size 5 
                  |> filled white
                  |> move (-30,-5)   
              ,text "d/dx (x^2) = 2x"
                  |> centered
                  |> bold 
                  |> size 5 
                  |> filled white
                  |> move (-30,-10)
              ,text "d/dx (a^x) = ln(a) * a^x"
                  |> centered
                  |> bold 
                  |> size 5 
                  |> filled white
                  |> move (-30,-15)
              ,text "d/dx (ln(x)) = 1/x"
                  |> centered
                  |> bold 
                  |> size 5 
                  |> filled white
                  |> move (-30,-20)
              ,derivativemenubutton"Back" |> move(-70,-55) |> notifyTap DHS11B
              ,derivativemenubutton"Next"|> move(80,-55) |> notifyTap DHS12T
              ,derivativemenubutton"Menu"|> move(80,50) |> notifyTap DHS11M
            ]
        DHS12  ->
            [ square 200
                  |> filled (rgb 0 188 212)
              ,text "Derivative Rules Overview"
                  |> centered
                  |> bold 
                  |> size 10
                  |> filled white
                  |> move (-30,47)
              ,text "Rule"
                  |> bold
                  |> size 5
                  |> filled white
                  |> move (-45,40)
              ,text "Function"
                  |> bold
                  |> size 5
                  |> filled white
                  |> move (-25,40)
              ,text "Derivative"
                  |> bold
                  |> size 5
                  |> filled white
                  |> move (5,40)
              ,text "Multiplication by constant"
                  |> bold
                  |> size 5
                  |> filled white
                  |> move (-92,35)
              ,text "Power Rule"
                  |> bold
                  |> size 5
                  |> filled white
                  |> move (-61,25)
              ,text "Sum Rule"
                  |> bold
                  |> size 5
                  |> filled white
                  |> move (-57,15)
              ,text "Difference Rule"
                  |> bold
                  |> size 5
                  |> filled white
                  |> move (-69,5)
              ,text "Product Rule"
                  |> bold
                  |> size 5
                  |> filled white
                  |> move (-64,-5)
              ,text "Quotient Rule"
                  |> bold
                  |> size 5
                  |> filled white
                  |> move (-66,-15)
              ,text "Reciprocal Rule"
                  |> bold
                  |> size 5
                  |> filled white
                  |> move (-70,-25)
              ,text "Chain Rule"
                  |> bold
                  |> size 5
                  |> filled white
                  |> move (-60,-35)
              ,text "cf"
                  |> bold
                  |> size 5
                  |> filled white
                  |> move (-25,35)
              ,text "x^n"
                  |> bold
                  |> size 5
                  |> filled white
                  |> move (-25,25)
              ,text "f + g"
                  |> bold
                  |> size 5
                  |> filled white
                  |> move (-25,15)
              ,text "f - g"
                  |> bold
                  |> size 5
                  |> filled white
                  |> move (-25,5)
              ,text "fg"
                  |> bold
                  |> size 5
                  |> filled white
                  |> move (-25,-5)
              ,text "f/g"
                  |> bold
                  |> size 5
                  |> filled white
                  |> move (-25,-15)
              ,text "1/f"
                  |> bold
                  |> size 5
                  |> filled white
                  |> move (-25,-25)
              ,text "f(g(x))"
                  |> bold
                  |> size 5
                  |> filled white
                  |> move (-25,-35)
              ,text "cf'"
                  |> bold
                  |> size 5
                  |> filled white
                  |> move (5,35)
              ,text "nx^(n-1)"
                  |> bold
                  |> size 5
                  |> filled white
                  |> move (5,25)
              ,text "f' + g'"
                  |> bold
                  |> size 5
                  |> filled white
                  |> move (5,15)
              ,text "f' - g'"
                  |> bold
                  |> size 5
                  |> filled white
                  |> move (5,5)
              ,text "f g' + f' g"
                  |> bold
                  |> size 5
                  |> filled white
                  |> move (5,-5)
              ,text "(f' g - g' f) / g^2"
                  |> bold
                  |> size 5
                  |> filled white
                  |> move (5,-15)
              ,text "-f' / f^2"
                  |> bold
                  |> size 5
                  |> filled white
                  |> move (5,-25)
              ,text "f'( g(x) ) g'(x)"
                  |> bold
                  |> size 5
                  |> filled white
                  |> move (5,-35)
              ,derivativemenubutton"Back" |> move(-70,-55) |> notifyTap DHS12B
              ,derivativemenubutton"Menu"|> move(80,50) |> notifyTap DHS12M
            ]

type Msg = Tick Float GetKeyState
         | IHStart
         | IHBack
         | DHStart
         | DHBack
         | IGStart
         | IGExit
         | DGStart
         | DGExit
         | IGFail
         | DGFail
         | IGQ1T
         | IGQ2T
         | IGQ3T
         | IGQ4T
         | IGQ5T
         | DGQ1T
         | DGQ2T
         | DGQ3T
         | DGQ4T
         | DGQ5T
         | IGPass
         | DGPass
         | IHS1T
         | S1S2
         | S2S3
         | IHS1B
         | S2S1
         | S3S2
         | IHS2T
         | IHS2B
         | IHS4T
         | IHS10B
         | DHS1B
         | DHS1T
         | DHS1M
         | DHS2B
         | DHS2T
         | DHS2M
         | DHS3B
         | DHS3T
         | DHS3M
         | DHS4B
         | DHS4T
         | DHS4M
         | DHS5B
         | DHS5T
         | DHS5M
         | DHS6B
         | DHS6T
         | DHS6M
         | DHS7B
         | DHS7T
         | DHS7M
         | DHS8B
         | DHS8T
         | DHS8M
         | DHS9B
         | DHS9T
         | DHS9M
         | DHS10B
         | DHS10T
         | DHS10M
         | DHS11B
         | DHS11T
         | DHS11M
         | DHS11Shortcut
         | DHS12B
         | DHS12T
         | DHS12M
         | DHS12Shortcut
         | NewQWin
         | NewQLose
         | Reset
         | IHExit
         | DHExit
         | S2SM
         | B1Down
         | B2Down
         | B3Down
         | B4Down
         | S3S4
         | S4S5
         | S5S6
         | S6S7
         | S7S8
         | S8S9
         | S9S10
         | S4S3
         | S5S4
         | S6S5
         | S7S6
         | S8S7
         | S9S8
         | S10S9
         | IHS7T
         | ShowGraph -- new
         | Drag (Float, Float) --new
         | ChangeDragState--new
         | RotL -- new
         | RotR -- new
         | Correct -- new
         | Success --new
         | Failure -- new
         | IHS3T
         | IHS3B
         | IHB

type State = Menu 
           | IntegralHelp 
           | DerivativeHelp 
           | IntegralGame 
           | DerivativeGame 
           | IGQ1 
           | IGQ2 
           | IGQ3 
           | IGQ4 
           | IGQ5 
           | DGQ1 
           | DGQ2 
           | DGQ3 
           | DGQ4 
           | DGQ5 
           | IHS1 
           | IHS2 
           | IHS3 
           | IHS4
           | IHS5
           | IHS6
           | IHS7
           | IHS8
           | IHS9
           | IHS10
           | DHS1 
           | DHS2 
           | DHS3 
           | DHS4 
           | DHS5 
           | DHS6
           | DHS7 
           | DHS8 
           | DHS9 
           | DHS10 
           | DHS11 
           | DHS12
           

-- Added derivative help slide transitions
update msg model =
    case msg of
        Tick t _ ->
            { model | time = t }
        IHStart ->
            case model.state of
                Menu  -> { model | b1= 1,state = IntegralHelp }
                IntegralGame -> { model | b1= 1,state = IntegralHelp }
                otherwise ->
                    model
        IHBack ->
            case model.state of 
                IntegralHelp ->
                    { model | state = Menu }
                otherwise ->
                    model
        DHStart ->
            case model.state of
                Menu  ->
                    { model | b2= 1, state = DerivativeHelp }
                otherwise ->
                    model
        DHBack ->
            case model.state of 
                DerivativeHelp ->
                    { model | state = Menu }
                otherwise ->
                    model
        
        IGStart ->
            case model.state of
                Menu  ->
                    { model | b3 = 1,state = IntegralGame }
                otherwise ->
                    model
        IGExit ->
            case model.state of
                IGQ1  ->
                    { model | state = IntegralGame  }
                IntegralGame ->
                    { model | state = Menu }
                otherwise ->
                    model
        DGStart ->
            case model.state of
                Menu  ->
                    { model | b4 = 1, state = DerivativeGame }
                otherwise ->
                    model
        DGExit ->
            case model.state of
                DerivativeGame  ->
                    { model | state = Menu  }
                otherwise ->
                    model
        IGFail ->
            case model.state of
                IGQ5  ->
                    { model | state = IntegralGame  }
                otherwise ->
                    model
        DGFail ->
            case model.state of
                DGQ4  ->
                    { model | state = DerivativeGame,
                              score = 0,
                              g = 0, -- NEW
                              rotate = 0, -- NEW
                              dragState = Released,
                              pos = (0,0),
                              s = 0,
                              f = 0 }
                otherwise ->
                    model
        IGQ1T ->
            case model.state of
                IntegralGame  ->
                    { model | state = IGQ1  }
                otherwise ->
                    model
        IGQ2T ->
            case model.state of
                IGQ1  ->
                    { model | state = IGQ2  }
                otherwise ->
                    model
        IGQ3T ->
            case model.state of
                IGQ2  ->
                    { model | state = IGQ3  }
                otherwise ->
                    model
        IGQ4T ->
            case model.state of
                IGQ3  ->
                    { model | state = IGQ4  }
                otherwise ->
                    model
        IGQ5T ->
            case model.state of
                IGQ4  ->
                    { model | state = IGQ5  }
                otherwise ->
                    model
        DGQ1T ->
            case model.state of
                DerivativeGame  ->
                    { model | state = DGQ1  }
                otherwise ->
                    model
        DGQ2T ->
            case model.state of
                DGQ1  ->
                    { model | state = DGQ2  }
                otherwise ->
                    model
        DGQ3T ->
            case model.state of
                DGQ2  ->
                    { model | state = DGQ3  }
                otherwise ->
                    model
        DGQ4T ->
            case model.state of
                DGQ3  ->
                    { model | state = DGQ4  }
                otherwise ->
                    model
        DGQ5T ->
            case model.state of
                DGQ4  ->
                    { model | state = DGQ5  }
                otherwise ->
                    model
        IGPass ->
            case model.state of
                IGQ5  ->
                    { model | state = Menu  }
                otherwise ->
                    model
        DGPass ->
            case model.state of
                DGQ4  ->
                    { model | state = Menu,
                              score = 0,
                              g = 0, -- NEW
                              rotate = 0, -- NEW
                              dragState = Released,
                              pos = (0,0),
                              s = 0,
                              f = 0 }
                otherwise ->
                    model
        IHS1T ->
            case model.state of
                IntegralHelp  ->
                    { model | state = IHS1  }
                otherwise ->
                    model
        DHS1T ->
            case model.state of
                DerivativeHelp  ->
                    { model | state = DHS1  }
                otherwise ->
                    model
        IHS1B ->
            case model.state of
                IHS1  ->
                    { model | state = IntegralHelp  }
                otherwise ->
                    model
        S2S1 ->
            case model.state of
                IHS2  ->
                    { model | state = IHS1  }
                otherwise ->
                    model
        S3S2 ->
            case model.state of
                IHS3  ->
                    { model | state = IHS2  }
                otherwise ->
                    model
        DHS1B ->
            case model.state of
                DHS1  ->
                    { model | state = DerivativeHelp  }
                otherwise ->
                    model
        DHS1M ->
            case model.state of
                DHS1  ->
                    { model | state = DerivativeHelp  }
                otherwise ->
                    model
        IHS2T ->
            case model.state of
                IntegralHelp  ->
                    { model | state = IHS2  }
                otherwise ->
                    model
        IHS2B ->
            case model.state of
                IHS2  ->
                    { model | state = IntegralHelp  }
                otherwise ->
                    model
        IHS3T ->
            case model.state of
                IntegralHelp  ->
                    { model | state = IHS3  }
                otherwise ->
                    model
        IHS3B ->
            case model.state of
                IHS3  ->
                    { model | state = IntegralHelp  }
                otherwise ->
                    model
        DHS2B ->
            case model.state of
                DHS2  ->
                    { model | state = DHS1  }
                otherwise ->
                    model
        DHS2T ->
            case model.state of
                DHS1  ->
                    { model | state = DHS2  }
                otherwise ->
                    model
        DHS2M ->
            case model.state of
                DHS2  ->
                    { model | state = DerivativeHelp  }
                otherwise ->
                    model
        DHS3B ->
            case model.state of
                DHS3  ->
                    { model | state = DHS2  }
                otherwise ->
                    model
        DHS3T ->
            case model.state of
                DHS2  ->
                    { model | state = DHS3  }
                otherwise ->
                    model
        DHS3M ->
            case model.state of
                DHS3  ->
                    { model | state = DerivativeHelp  }
                otherwise ->
                    model
        DHS4B ->
            case model.state of
                DHS4  ->
                    { model | state = DHS3  }
                otherwise ->
                    model
        DHS4T ->
            case model.state of
                DHS3  ->
                    { model | state = DHS4  }
                otherwise ->
                    model
        DHS4M ->
            case model.state of
                DHS4  ->
                    { model | state = DerivativeHelp  }
                otherwise ->
                    model
        DHS5B ->
            case model.state of
                DHS5  ->
                    { model | state = DHS4  }
                otherwise ->
                    model
        DHS5T ->
            case model.state of
                DHS4  ->
                    { model | state = DHS5  }
                otherwise ->
                    model
        DHS5M ->
            case model.state of
                DHS5  ->
                    { model | state = DerivativeHelp  }
                otherwise ->
                    model
        DHS6B ->
            case model.state of
                DHS6  ->
                    { model | state = DHS5  }
                otherwise ->
                    model
        DHS6T ->
            case model.state of
                DHS5  ->
                    { model | state = DHS6  }
                otherwise ->
                    model
        DHS6M ->
            case model.state of
                DHS6  ->
                    { model | state = DerivativeHelp  }
                otherwise ->
                    model
        DHS7B ->
            case model.state of
                DHS7  ->
                    { model | state = DHS6  }
                otherwise ->
                    model
        DHS7T ->
            case model.state of
                DHS6  ->
                    { model | state = DHS7  }
                otherwise ->
                    model
        DHS7M ->
            case model.state of
                DHS7  ->
                    { model | state = DerivativeHelp  }
                otherwise ->
                    model
        DHS8B ->
            case model.state of
                DHS8  ->
                    { model | state = DHS7  }
                otherwise ->
                    model
        DHS8T ->
            case model.state of
                DHS7  ->
                    { model | state = DHS8  }
                otherwise ->
                    model
        DHS8M ->
            case model.state of
                DHS8  ->
                    { model | state = DerivativeHelp  }
                otherwise ->
                    model
        DHS9B ->
            case model.state of
                DHS9  ->
                    { model | state = DHS8  }
                otherwise ->
                    model
        DHS9T ->
            case model.state of
                DHS8  ->
                    { model | state = DHS9  }
                otherwise ->
                    model
        DHS9M ->
            case model.state of
                DHS9  ->
                    { model | state = DerivativeHelp  }
                otherwise ->
                    model
        DHS10B ->
            case model.state of
                DHS10  ->
                    { model | state = DHS9  }
                otherwise ->
                    model
        DHS10T ->
            case model.state of
                DHS9  ->
                    { model | state = DHS10  }
                otherwise ->
                    model
        DHS10M ->
            case model.state of
                DHS10  ->
                    { model | state = DerivativeHelp  }
                otherwise ->
                    model
        DHS11B ->
            case model.state of
                DHS11  ->
                    { model | state = DHS10 }
                otherwise ->
                    model
        DHS11T ->
            case model.state of
                DHS10  ->
                    { model | state = DHS11  }
                otherwise ->
                    model
        DHS11M ->
            case model.state of
                DHS11  ->
                    { model | state = DerivativeHelp  }
                otherwise ->
                    model
        DHS11Shortcut ->
            case model.state of
                DerivativeHelp  ->
                    { model | state = DHS11  }
                otherwise ->
                    model
        DHS12B ->
            case model.state of
                DHS12  ->
                    { model | state = DHS11  }
                otherwise ->
                    model
        DHS12T ->
            case model.state of
                DHS11  ->
                    { model | state = DHS12  }
                otherwise ->
                    model
        DHS12M ->
            case model.state of
                DHS12  ->
                    { model | state = DerivativeHelp  }
                otherwise ->
                    model
        DHS12Shortcut ->
            case model.state of
                DerivativeHelp  ->
                    { model | state = DHS12  }
                otherwise ->
                    model
        NewQWin -> {model | otherTime = model.time,
                                         score = model.score + 1}
        NewQLose -> {model | otherTime = model.time}
        Reset -> {model | score = 0, otherTime = 0}
        IHExit -> case model.state of 
                      IntegralHelp -> {model | state = Menu}
                      IHS1 ->{model | state = Menu}
                      IHS2 ->{model | state = Menu}
                      IHS3 -> {model | state = Menu}
                      otherwise -> model
        DHExit -> case model.state of 
                      DerivativeHelp -> {model | state = Menu}
                      DHS1 ->{model | state = Menu}
                      DHS2 ->{model | state = Menu}
                      DHS3 -> {model | state = Menu}
                      otherwise -> model
        S2SM -> case model.state of 
                      IHS3 -> {model | state = IntegralHelp}
                      otherwise -> model
        B1Down -> {model | b1 = 0.95}
        B2Down -> {model | b2 = 0.95}
        B3Down -> {model | b3 = 0.95}
        B4Down -> {model | b4 = 0.95}
        ShowGraph -> {model | g = if model.g == 1 then 0 else 1, pos = (0,0), rotate = 0} --new
        Drag (x, y) -> { model | pos = case model.dragState of 
                                         Dragging -> (x , y)
                                         Released -> model.pos --new
                       }
                     
        ChangeDragState -> { model | dragState = case model.dragState of
                                                   Released -> Dragging
                                                   Dragging -> Released
                           } -- new
        RotL -> { model | rotate = model.rotate + 2 } --new
        RotR -> { model | rotate = model.rotate - 2 } -- new
        Correct -> case model.state of
                     DGQ1 -> {model | state = DGQ2, s = 0, f = 0}
                     DGQ2 -> {model | state = DGQ3, s = 0, f = 0}
                     DGQ3 -> {model | state = DGQ4, s = 0, f = 0}
                     otherwise -> model
        Success -> {model | s = if model.s == 1 then 0 else 1, score = model.score + 1}
        Failure -> {model | f = if model.f == 1 then 0 else 1}
        S1S2 ->
            case model.state of
                IHS1  ->
                    { model | state = IHS2  }
                otherwise ->
                    model
        S2S3 ->
            case model.state of
                IHS2  ->
                    { model | state = IHS3  }
                otherwise ->
                    model
        S3S4 ->
            case model.state of
                IHS3  ->
                    { model | state = IHS4  }
                otherwise ->
                    model
        S4S5 ->
            case model.state of
                IHS4  ->
                    { model | state = IHS5  }
                otherwise ->
                    model
        S5S6 ->
            case model.state of
                IHS5  ->
                    { model | state = IHS6  }
                otherwise ->
                    model
        S6S7 ->
            case model.state of
                IHS6  ->
                    { model | state = IHS7  }
                otherwise ->
                    model
        S7S8 ->
            case model.state of
                IHS7  ->
                    { model | state = IHS8  }
                otherwise ->
                    model
                    
        S8S9 ->
            case model.state of
                IHS8  ->
                    { model | state = IHS9  }
                otherwise ->
                    model
        S9S10 ->
            case model.state of
                IHS9  ->
                    { model | state = IHS10  }
                otherwise ->
                    model
        S4S3 ->
            case model.state of
                IHS4  ->
                    { model | state = IHS3  }
                otherwise ->
                    model
        S5S4 ->
            case model.state of
                IHS5  ->
                    { model | state = IHS4  }
                otherwise ->
                    model
        S6S5 ->
            case model.state of
                IHS6  ->
                    { model | state = IHS5  }
                otherwise ->
                    model
        S7S6 ->
            case model.state of
                IHS7  ->
                    { model | state = IHS6  }
                otherwise ->
                    model
        S8S7 ->
            case model.state of
                IHS8  ->
                    { model | state = IHS7  }
                otherwise ->
                    model
        S9S8 ->
            case model.state of
                IHS9  ->
                    { model | state = IHS8  }
                otherwise ->
                    model
        S10S9 ->
            case model.state of
                IHS10  ->
                    { model | state = IHS9  }
                otherwise ->
                    model
        IHS4T ->
            case model.state of
                IntegralHelp  ->
                    { model | state = IHS4  }
                otherwise ->
                    model
        IHS7T ->
            case model.state of
                IntegralHelp  ->
                    { model | state = IHS7  }
                otherwise ->
                    model
        IHS10B ->
            case model.state of
                IHS10  ->
                    { model | state = IntegralHelp  }
                otherwise ->
                    model
        IHB ->
            case model.state of
                _      ->
                    { model | state = IntegralHelp  }
                      
                   --- Functions/Variables and Shapes --
-- The background color I used is (rgb 0 188 212) and the Orange color I used is (rgb 255 160 0) --

type DragState = Released | Dragging
type Color = Purple | Orange | Red
getColor c = case c of 
               Purple -> purple
               Orange -> (rgb 255 160 0)
               Red    -> lightRed
               
fancytext s c = group [text s |> size 20 |> bold |> centered |> customFont "Helvetica" |> outlined (solid 1.5) white  |> move(0,0),
                       text s |> size 20 |> bold |> centered |> customFont "Helvetica" |> filled (getColor c) |> move(0,0.7)]
                       
menucontent = group [ rectangle 200 200 |> filled (rgb 0 188 212),
                      fancytext "Math Menu" Orange |> move (0,45),
                      text "dy" |> centered |> filled black,
                      text "dx" |> centered |> filled black]
menubutton s = group [ roundedRect (toFloat (String.length s)*6) 17 2 |> filled (rgb 255 111 0) |> move (1,1),
                       roundedRect (toFloat (String.length s)*6) 17 2 |> filled (rgb 255 160 0) |> move (0,3),
                       text s |> customFont "Helvetica" |> size 9 |> centered |> filled white] |> scale 0.9

integralmenubutton s = group [ roundedRect (toFloat (String.length s)*6) 17 2 |> filled purple |> move (1,1),
                       roundedRect (toFloat (String.length s)*6) 17 2 |> filled lightPurple |> move (0,3),
                       text s |> customFont "Helvetica" |> size 9 |> centered |> filled white] |> scale 0.9
                       
derivativemenubutton s = group [ roundedRect (toFloat (String.length s)*6) 17 2 |> filled red |> move (1,1),
                       roundedRect (toFloat (String.length s)*6) 17 2 |> filled lightRed |> move (0,3),
                       text s |> customFont "Helvetica" |> size 9 |> centered |> filled white] |> scale 0.9
exitbutton = group [ roundedRect 30 17 2 |> filled red |> move (1,1),
                     roundedRect 30 17 2 |> filled lightRed |> move (0,3),
                     triangle 6 |> filled white |> rotate (degrees -60) |> move (-5,3),
                     rectangle 10 5 |>filled white |> move (2,3)] |> scale 0.7
                     
gameComplete s = group [ rect 200 200 |> filled (rgb 0 188 212),
                  roundedRect 165 40 2 |> filled (rgb 0 176 73) |> move(2,-3),
                  roundedRect 165 40 2 |> filled (rgb 0 200 83),
                  text ("Congratulations!") |> centered |> bold |> filled white |> move (0,5),
                  text ("You completed the "++s++" game.") |> centered|> filled white |> move (0,-10) ]
howtoIntegral= group [ square 200 |> filled (rgb 0 188 212),
                        fancytext "Integral Quiz Game" Purple |> move(0,45),
                        integralmenubutton "Start Game" |> move(0,10) |> notifyTap IGQ1T,
                        integralmenubutton "Help" |> move(0,-10) |> notifyTap IHStart]
                        
howtoDerivative = group [ square 200 |> filled (rgb 0 188 212),
                        fancytext "Derivative Quiz Game" Red |> move(0,45) |> scale 0.9,
                        derivativemenubutton "Start Game" |> move(0,10) |> notifyTap DGQ1T,
                        derivativemenubutton "Help" |> move(0,-10)]

graph model q = 
          let
            imageUrl = q.graph 
            width = 800
            height = 800
            imageScale = 0.18
            imageMove = (-70,64)
            pic = move imageMove <| scale imageScale <| html width height <| Html.img [Html.Attributes.src imageUrl][]
          in
            group [ square 200 |> filled white,
                    pic,
                    square 200 |> ghost,
                    line 0 |> rotate (degrees model.rotate) |> move model.pos  |> notifyMouseDown ChangeDragState,
                    menubutton "Rotate Left"  |> scale 0.5 |> move (-79,-58) |> notifyTap RotL,
                    menubutton "Rotate Right" |> scale 0.5 |> move (78,-58) |> notifyTap RotR,
                    exitbutton |> scale 0.7 |> move (-83,55) |> notifyTap ShowGraph,
                    case model.dragState of 
                     Released -> group []
                     Dragging -> rect 185 125 
                         |> ghost 
                         |> notifyMouseMoveAt Drag 
                         |> notifyLeave ChangeDragState 
                         |> notifyMouseUp ChangeDragState 
                  ]
completedD model = group [square 200 |> filled (rgb 0 188 212),
                          fancytext ("Your score: "++ String.fromInt model.score) Red, 
                          derivativemenubutton "Try again?" |> move (0,-15) |> notifyTap DGFail,
                          exitbutton |> move (0,-35) |> notifyTap DGPass ]
successD = group [ square 200 |> ghost,
                   text "Correct!" |> customFont "Helvetica" |> centered |> filled green |> move (-70,-56),
                   menubutton "Next" |> move (0,-54) |> notifyTap Correct
                 ]
failD = group [ square 200 |> ghost,
                text "Incorrect!" |> customFont "Helvetica" |> centered |> filled lightRed |> move (-65,-56),
                menubutton "Next" |> move (0,-54) |> notifyTap Correct
              ]
qDBG q = group [ square 200 |> filled (rgb 0 188 212),
                 rectangle 187 123 |> filled lightGrey |> move(1,-1),
                 rectangle 187 123 |> filled white,
                 questions (q.formula) Red
               ]
qDContent model q = group [ qDBG q,
                            q.correctA |> notifyTap Success,
                            q.a1 |> notifyTap Failure,
                            q.a2 |> notifyTap Failure,
                            q.a3 |> notifyTap Failure,
                            derivativemenubutton "Graph" |> move(79,-54) |> notifyTap ShowGraph,
                            graph model q |> scale model.g,
                            successD |> scale model.s,
                            failD |> scale model.f
                          ]
derivativePic = move (-45,15) <| scale 0.25 <| html 400 280 <| Html.img [Html.Attributes.src "https://upload.wikimedia.org/wikipedia/commons/0/0f/Tangent_to_a_curve.svg"][]
type alias QuestionD = {formula : String, graph : String ,correctA : Shape Msg, a1 : Shape Msg, a2 : Shape Msg, a3 : Shape Msg}
type alias Question = {formula : String, graph : Shape Msg,correctA : Shape Msg,a1 : Shape Msg,a2 : Shape Msg,a3 : Shape Msg}

line a = rect 1 50 |> filled black |> rotate (degrees -90 + a)
questions s c = text ("Find the derivative of "++s) |> customFont "Helvetica" |> centered |> filled (getColor c) |> scale 0.8 |> move(0,50)
q1d = {formula = "f(x) = x^2 at x = 4", graph = "https://raw.githubusercontent.com/JadenMathias/Obsticale-Course/main/x2.PNG", correctA = line 82.9 |> move (-75,0), a1 = line 90 |> move (-30,0), a2 = line 70 |> move (30,0) , a3 = line 45 |> move (75,0)}
q2d = {formula = "f(x) = sin(x) at x = 3", graph = "https://raw.githubusercontent.com/JadenMathias/Obsticale-Course/main/sinx.png", a2 = line 90 |> move (-75,0), a1 = line 120 |> move (-30,0), correctA = line -44.4 |> move (30,0) , a3 = line 35 |> move (70,-10)}
q3d = {formula = "f(x) = e^x at x = 0", graph = "https://raw.githubusercontent.com/JadenMathias/Obsticale-Course/main/ex.png", a2 = line 90 |> move (-75,0), a1 = line 0 |> move (-30,0), a3 = line -120 |> move (30,0) , correctA = line 45 |> move (70,-10)}

q1i = {formula = "Find the integral of f(x) = x/(x^2+9) from 0 to 1", graph = group[rect 50 50 |> filled red], correctA = "1/2(ln10-ln9)", a1 = "1/2(ln1-ln10)", a2 = "ln10-ln9", a3= "ln1-ln10", cap = (-20,0), a1p = (-60,0), a2p = (60,0), a3p = (20,0)}
q2i = {formula = "Find the integral of f(x) = (tan x)^2 from 0 to pi/4", graph = group[rect 50 50 |> filled blue], correctA = "1 - pi/4", a1 = "1 + pi/4", a2 = "1 - pi/2", a3= "1 + pi/2", cap = (20,0), a1p = (-60,0), a2p = (60,0), a3p = (-20,0)}
q3i = {formula = "Find the integral of f(x) = (1-x)/(1+x) from 0 to 1", graph = group[rect 50 50 |> filled green], correctA = "2ln2 - 1", a1 = "(1/2)ln2", a2 = "2ln2 + 1", a3= "(1/2)ln2 - 1", cap = (60,0), a1p = (-60,0), a2p = (20,0), a3p = (-20,0)}
q4i = {formula = "Find the integral of f(x) = x(1-x^2)^95 from 0 to 1", graph = group[rect 50 50 |> filled green], correctA = "1/192", a1 = "-1/192", a2 = "-1/96", a3= "1/96", cap = (-60,0), a1p = (20,0), a2p = (60,0), a3p = (-20,0)}
q5i = {formula = "Find the integral of f(x) = 3x^2 - 4x + 2 from -1 to 2", graph = group[rect 50 50 |> filled green], correctA = "9", a1 = "14", a2 = "-2", a3= "21", cap = (20,0), a1p = (-60,0), a2p = (60,0), a3p = (-20,0)}
q6i = {formula = "Find the integral of f(x) = (x^7)sin(x^4) from 0 to pi^(1/4)", graph = group[rect 50 50 |> filled green], correctA = "pi/4", a1 = "pi/3", a2 = "3pi/2", a3= "pi", cap = (-20,0), a1p = (60,0), a2p = (-60,0), a3p = (20,0)}
q7i = {formula = "Find the integral of f(x) = arctanx from 0 to 1", graph = group[rect 50 50 |> filled green], correctA = "pi/4 - ln2/2", a1 = "pi/2 - ln2", a2 = "-ln2/2", a3= "pi/2", cap = (20,0), a1p = (-60,0), a2p = (60,0), a3p = (-20,0)}
q8i = {formula = "Find the integral of f(x) = (sinx)^2 from 0 to pi", graph = group[rect 50 50 |> filled green], correctA = "pi/2", a1 = "pi", a2 = "pi/3", a3= "3pi/2", cap = (60,0), a1p = (-60,0), a2p = (20,0), a3p = (-20,0)}
q9i = {formula = "Find the integral of f(x) = (2+x^3)/sqrt(x) from 1 to 9", graph = group[rect 50 50 |> filled green], correctA = "4428/7", a1 = "4458/7", a2 = "4488/7", a3= "-4458/7", cap = (-60,0), a1p = (60,0), a2p = (20,0), a3p = (-20,0)}
q10i = {formula = "Find the integral of f(x) = 2^x from 0 to 4", graph = group[rect 50 50 |> filled green], correctA = "16/ln2 - 1/ln2", a1 = "16/ln2", a2 = "2/ln2", a3= "16", cap = (-20,0), a1p = (-60,0), a2p = (20,0), a3p = (60,0)}

-- Nothing is changed down here---
type alias Model =
    { time : Float
    , state : State
    , otherTime : Float
    , score : Int
    , b1 : Float
    , b2 : Float
    , b3 : Float
    , b4 : Float
    , g  : Float -- NEW
    , rotate : Float
    , dragState : DragState
    , pos : (Float,Float)
    , s : Float
    , f : Float
    }

init : Model
init = { time = 0 
       , state = Menu 
       , otherTime = 0
       , score = 0
       , b1 = 1
       , b2 =1
       , b3 =1
       , b4 =1
       , g = 0 -- NEW
       , rotate = 0 -- NEW
       , dragState = Released
       , pos = (0,0)
       , s = 0
       , f = 0
       }
imageUrl1 = "https://www.mathsisfun.com/calculus/images/integral-area.svg"
imageUrl2 = "https://trigidentities.net/wp-content/uploads/2020/06/Screenshot-2020-06-03-at-11.13.37-PM.png"
imageUrl3in="https://www.mathsisfun.com/calculus/images/indefinite-integral.gif"
imageUrl3de="https://www.mathsisfun.com/calculus/images/definite-integral.gif"
imageUrl4 = "https://miro.medium.com/max/643/0*ynUp6owVP9zIIpVz.png"
imageUrl5 ="https://www.mathsisfun.com/calculus/images/integral-notation-2.gif"
imageUrl5add="https://www.mathsisfun.com/calculus/images/integrals-vs-derivative.svg"
imageUrl6="https://www.mathsisfun.com/calculus/images/integral-parts-general.gif"
imageUrl7="https://www.onlinemathlearning.com/image-files/integration-by-parts-eg.png"
imageUrl81="https://www.mathsisfun.com/calculus/images/integral-subs-1.svg"
imageUrl82="https://www.mathsisfun.com/calculus/images/integral-subs-2.svg"
imageUrl9="https://www.mathsisfun.com/calculus/images/integral-subs-6.svg"
imageWidth = 1280
imageHeight = 1200
imageScale1 = 0.3
imageScale2 = 0.155
imageScale3 = 0.3
imageScale4 = 0.25
imageScale5 = 0.15
imageScale6 = 0.3
imageScale7=0.4
imageScale8=0.2
imageScale9=0.2
imageMove1 = (0,10)
imageMove2=(-55,60)
imageMove3in=(-60,20)
imageMove3de=(10,20)
imageMove4=(-60,50)
imageMove5=(-50,20)
imageMove5add=(-50,-10)
imageMove6=(-50,20)
imageMove7=(-65,30)
imageMove81=(-50,20)
imageMove82=(-50,-5)
imageMove9=(-70,0)
pic1 = move imageMove1 <| scale imageScale1 <| html imageWidth imageHeight <| Html.img [Html.Attributes.src imageUrl1][]
pic2 = move imageMove2 <| scale imageScale2 <| html imageWidth imageHeight <| Html.img [Html.Attributes.src imageUrl2][]
pic4 = move imageMove4 <| scale imageScale4 <| html imageWidth imageHeight <| Html.img [Html.Attributes.src imageUrl4][]
pic3in=move imageMove3in <| scale imageScale3 <| html imageWidth imageHeight <| Html.img [Html.Attributes.src imageUrl3in][]
pic3de=move imageMove3de <| scale imageScale3 <| html imageWidth imageHeight <| Html.img [Html.Attributes.src imageUrl3de][]
pic5= move imageMove5 <| scale imageScale5 <| html imageWidth imageHeight <| Html.img [Html.Attributes.src imageUrl5][]
pic5add=move imageMove5add <| scale imageScale5 <| html imageWidth imageHeight <| Html.img [Html.Attributes.src imageUrl5add][]
pic6=move imageMove6 <| scale imageScale6 <| html imageWidth imageHeight <| Html.img [Html.Attributes.src imageUrl6][]
pic7 = move imageMove7 <| scale imageScale7 <| html imageWidth imageHeight <| Html.img [Html.Attributes.src imageUrl7][]
pic81 = move imageMove81 <| scale imageScale8 <| html imageWidth imageHeight <| Html.img [Html.Attributes.src imageUrl81][]
pic82 = move imageMove82 <| scale imageScale8 <| html imageWidth imageHeight <| Html.img [Html.Attributes.src imageUrl82][]
pic9 = move imageMove9 <| scale imageScale9 <| html imageWidth imageHeight <| Html.img [Html.Attributes.src imageUrl9][]