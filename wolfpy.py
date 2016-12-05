from time import sleep
from fractions import Fraction
class relay:
    def __str__(self):
        return 'Input:  "'+open('relay.ramdisk/relayi','r').read()+'"\nOutput: "'+self.Result()+'"'


    def Evaluate(self, expr, *, evaluate = True, wait = True):
        result = self.Result()
        if expr != open('relay.ramdisk/relayi','r').read(): #save time
            lastResult = self.Result()
            open('relay.ramdisk/relayi','w').write(expr)
            if wait:
                while lastResult == result:
                    result = self.Result()
                    sleep(.1)
        sleep(.0001)  # if this isn't here then the result returns ''
        if evaluate:
            try: result = eval(result)
            except: pass
        if type(result) is not str or 'Graphics' not in result:
            return result

    def Result(self):                                                                           
        return open('relay.ramdisk/relayo','r').read()                                          

    def Clear(self):  # I *think* that this'll clear up RAM if ever needed
        open('relay.ramdisk/relayi','w').write('Remove@ "Global`*";"Cleared Global context"')
