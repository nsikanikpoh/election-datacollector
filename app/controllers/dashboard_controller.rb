class DashboardController < ApplicationController
	def dashboard
		@reports = Report.all
		@polling_units = PollingUnit.all
		@council_wards = CouncilWard.all
		@pdp_votes = 0
		@apc_votes = 0
		@apga_votes = 0
		@prp_votes = 0
		@lab_votes = 0
		@ypp_votes = 0


		if @reports
         	@reports.each do |u| 
              @pdp_votes += u.pdp_votes
              @prp_votes += u.prp_votes
              @ypp_votes += u.ypp_votes
              @apc_votes += u.apc_votes
              @apga_votes += u.apga_votes
              @lab_votes += u.labour_party

           end
    	end



		  chartData = {

        "chart": {
          "caption": "Eagle Election Monitoring",
          "subCaption": "Votes collated by agents",
          "showValues": "1",
          "showPercentInTooltip": "0",
          "enableMultiSlicing": "1",
          "theme": "fusion"
        },
        "data": [{
          "label": "APC",
          "value": @apc_votes.to_s
        }, {
          "label": "PDP",
          "value": @pdp_votes.to_s
        }, {
          "label": "APGA",
          "value": @apga_votes.to_s
        }, {
          "label": "PRP",
          "value": @prp_votes.to_s
        }, {
          "label": "LABOUR PARTY",
          "value": @lab_votes.to_s
        }, {
          "label": "YPP",
          "value": @ypp_votes.to_s
        }

      ]
      }   

        # Chart rendering 
        @chart = Fusioncharts::Chart.new({
                width: "600",
                height: "400",
                type: "pie3d",
                renderAt: "chartContainer",
                dataSource: chartData
            })

	end


def presidential

  @reports = Report.where(election_type: "Presidential")
    @polling_units = PollingUnit.all
    @council_wards = CouncilWard.all
    @pdp_votes = 0
    @apc_votes = 0
    @apga_votes = 0
    @prp_votes = 0
    @lab_votes = 0
    @ypp_votes = 0


    if @reports
          @reports.each do |u| 
              @pdp_votes += u.pdp_votes
              @prp_votes += u.prp_votes
              @ypp_votes += u.ypp_votes
              @apc_votes += u.apc_votes
              @apga_votes += u.apga_votes
              @lab_votes += u.labour_party

           end
      end



    
      chartData = {

        "chart": {
          "caption": "Eagle Election Monitoring",
          "subCaption": "Votes collated by agents",
          "showValues": "1",
          "showPercentInTooltip": "0",
          "enableMultiSlicing": "1",
          "theme": "fusion"
        },
        "data": [{
          "label": "APC",
          "value": @apc_votes.to_s
        }, {
          "label": "PDP",
          "value": @pdp_votes.to_s
        }, {
          "label": "APGA",
          "value": @apga_votes.to_s
        }, {
          "label": "PRP",
          "value": @prp_votes.to_s
        }, {
          "label": "LABOUR PARTY",
          "value": @lab_votes.to_s
        }, {
          "label": "YPP",
          "value": @ypp_votes.to_s
        }

      ]
      }   

        # Chart rendering 
        @chart = Fusioncharts::Chart.new({
                width: "600",
                height: "400",
                type: "pie3d",
                renderAt: "chartContainer",
                dataSource: chartData
            })


end


def lga_presidential

  @reports = Report.where(election_type: "Presidential", lga: params[:lga])
    @polling_units = PollingUnit.where(lga: params[:lga])
    @council_wards = CouncilWard.where(lga: params[:lga])
    @lga = params[:lga]
    @pdp_votes = 0
    @apc_votes = 0
    @apga_votes = 0
    @prp_votes = 0
    @lab_votes = 0
    @ypp_votes = 0


    if @reports
          @reports.each do |u| 
              @pdp_votes += u.pdp_votes
              @prp_votes += u.prp_votes
              @ypp_votes += u.ypp_votes
              @apc_votes += u.apc_votes
              @apga_votes += u.apga_votes
              @lab_votes += u.labour_party

           end
      end



    
      chartData = {

        "chart": {
          "caption": "Eagle Election Monitoring",
          "subCaption": "Votes collated by agents",
          "showValues": "1",
          "showPercentInTooltip": "0",
          "enableMultiSlicing": "1",
          "theme": "fusion"
        },
        "data": [{
          "label": "APC",
          "value": @apc_votes.to_s
        }, {
          "label": "PDP",
          "value": @pdp_votes.to_s
        }, {
          "label": "APGA",
          "value": @apga_votes.to_s
        }, {
          "label": "PRP",
          "value": @prp_votes.to_s
        }, {
          "label": "LABOUR PARTY",
          "value": @lab_votes.to_s
        }, {
          "label": "YPP",
          "value": @ypp_votes.to_s
        }

      ]
      }   

        # Chart rendering 
        @chart = Fusioncharts::Chart.new({
                width: "600",
                height: "400",
                type: "pie3d",
                renderAt: "chartContainer",
                dataSource: chartData
            })


end

def senatorial

    @reports = Report.where(election_type: "Senatorial")
    @polling_units = PollingUnit.all
    @council_wards = CouncilWard.all
    @pdp_votes = 0
    @apc_votes = 0
    @apga_votes = 0
    @prp_votes = 0
    @lab_votes = 0
    @ypp_votes = 0


    if @reports
          @reports.each do |u| 
              @pdp_votes += u.pdp_votes
              @prp_votes += u.prp_votes
              @ypp_votes += u.ypp_votes
              @apc_votes += u.apc_votes
              @apga_votes += u.apga_votes
              @lab_votes += u.labour_party

           end
      end



     
      chartData = {

        "chart": {
          "caption": "Eagle Election Monitoring",
          "subCaption": "Votes collated by agents",
          "showValues": "1",
          "showPercentInTooltip": "0",
          "enableMultiSlicing": "1",
          "theme": "fusion"
        },
        "data": [{
          "label": "APC",
          "value": @apc_votes.to_s
        }, {
          "label": "PDP",
          "value": @pdp_votes.to_s
        }, {
          "label": "APGA",
          "value": @apga_votes.to_s
        }, {
          "label": "PRP",
          "value": @prp_votes.to_s
        }, {
          "label": "LABOUR PARTY",
          "value": @lab_votes.to_s
        }, {
          "label": "YPP",
          "value": @ypp_votes.to_s
        }

      ]
      }   

        # Chart rendering 
        @chart = Fusioncharts::Chart.new({
                width: "600",
                height: "400",
                type: "pie3d",
                renderAt: "chartContainer",
                dataSource: chartData
            })


end


def lga_senatorial

    @reports = Report.where(election_type: "Senatorial", lga: params[:lga])
    @polling_units = PollingUnit.where(lga: params[:lga])
    @council_wards = CouncilWard.where(lga: params[:lga])
    @lga = params[:lga]
    @pdp_votes = 0
    @apc_votes = 0
    @apga_votes = 0
    @prp_votes = 0
    @lab_votes = 0
    @ypp_votes = 0


    if @reports
          @reports.each do |u| 
              @pdp_votes += u.pdp_votes
              @prp_votes += u.prp_votes
              @ypp_votes += u.ypp_votes
              @apc_votes += u.apc_votes
              @apga_votes += u.apga_votes
              @lab_votes += u.labour_party

           end
      end



     
      chartData = {

        "chart": {
          "caption": "Eagle Election Monitoring",
          "subCaption": "Votes collated by agents",
          "showValues": "1",
          "showPercentInTooltip": "0",
          "enableMultiSlicing": "1",
          "theme": "fusion"
        },
        "data": [{
          "label": "APC",
          "value": @apc_votes.to_s
        }, {
          "label": "PDP",
          "value": @pdp_votes.to_s
        }, {
          "label": "APGA",
          "value": @apga_votes.to_s
        }, {
          "label": "PRP",
          "value": @prp_votes.to_s
        }, {
          "label": "LABOUR PARTY",
          "value": @lab_votes.to_s
        }, {
          "label": "YPP",
          "value": @ypp_votes.to_s
        }

      ]
      }   

        # Chart rendering 
        @chart = Fusioncharts::Chart.new({
                width: "600",
                height: "400",
                type: "pie3d",
                renderAt: "chartContainer",
                dataSource: chartData
            })


end

def rep

    @reports = Report.where(election_type: "House of Representative")
    @polling_units = PollingUnit.all
    @council_wards = CouncilWard.all
    @pdp_votes = 0
    @apc_votes = 0
    @apga_votes = 0
    @prp_votes = 0
    @lab_votes = 0
    @ypp_votes = 0


    if @reports
          @reports.each do |u| 
              @pdp_votes += u.pdp_votes
              @prp_votes += u.prp_votes
              @ypp_votes += u.ypp_votes
              @apc_votes += u.apc_votes
              @apga_votes += u.apga_votes
              @lab_votes += u.labour_party

           end
      end



      
      chartData = {

        "chart": {
          "caption": "Eagle Election Monitoring",
          "subCaption": "Votes collated by agents",
          "showValues": "1",
          "showPercentInTooltip": "0",
          "enableMultiSlicing": "1",
          "theme": "fusion"
        },
        "data": [{
          "label": "APC",
          "value": @apc_votes.to_s
        }, {
          "label": "PDP",
          "value": @pdp_votes.to_s
        }, {
          "label": "APGA",
          "value": @apga_votes.to_s
        }, {
          "label": "PRP",
          "value": @prp_votes.to_s
        }, {
          "label": "LABOUR PARTY",
          "value": @lab_votes.to_s
        }, {
          "label": "YPP",
          "value": @ypp_votes.to_s
        }

      ]
      }   

        # Chart rendering 
        @chart = Fusioncharts::Chart.new({
                width: "600",
                height: "400",
                type: "pie3d",
                renderAt: "chartContainer",
                dataSource: chartData
            })



end


def lga_rep

    @reports = Report.where(election_type: "House of Representative", lga: params[:lga])
    @polling_units = PollingUnit.where(lga: params[:lga])
    @council_wards = CouncilWard.where(lga: params[:lga])
    @lga = params[:lga]
    @pdp_votes = 0
    @apc_votes = 0
    @apga_votes = 0
    @prp_votes = 0
    @lab_votes = 0
    @ypp_votes = 0


    if @reports
          @reports.each do |u| 
              @pdp_votes += u.pdp_votes
              @prp_votes += u.prp_votes
              @ypp_votes += u.ypp_votes
              @apc_votes += u.apc_votes
              @apga_votes += u.apga_votes
              @lab_votes += u.labour_party

           end
      end



      
      chartData = {

        "chart": {
          "caption": "Eagle Election Monitoring",
          "subCaption": "Votes collated by agents",
          "showValues": "1",
          "showPercentInTooltip": "0",
          "enableMultiSlicing": "1",
          "theme": "fusion"
        },
        "data": [{
          "label": "APC",
          "value": @apc_votes.to_s
        }, {
          "label": "PDP",
          "value": @pdp_votes.to_s
        }, {
          "label": "APGA",
          "value": @apga_votes.to_s
        }, {
          "label": "PRP",
          "value": @prp_votes.to_s
        }, {
          "label": "LABOUR PARTY",
          "value": @lab_votes.to_s
        }, {
          "label": "YPP",
          "value": @ypp_votes.to_s
        }

      ]
      }   

        # Chart rendering 
        @chart = Fusioncharts::Chart.new({
                width: "600",
                height: "400",
                type: "pie3d",
                renderAt: "chartContainer",
                dataSource: chartData
            })



end


def lga_assembly

   @reports = Report.where(election_type: "House of Assembly", lga: params[:lga])
    @polling_units = PollingUnit.where(lga: params[:lga])
    @council_wards = CouncilWard.where(lga: params[:lga])
    @lga = params[:lga]
    @pdp_votes = 0
    @apc_votes = 0
    @apga_votes = 0
    @prp_votes = 0
    @lab_votes = 0
    @ypp_votes = 0


    if @reports
          @reports.each do |u| 
              @pdp_votes += u.pdp_votes
              @prp_votes += u.prp_votes
              @ypp_votes += u.ypp_votes
              @apc_votes += u.apc_votes
              @apga_votes += u.apga_votes
              @lab_votes += u.labour_party

           end
      end



      
      chartData = {

        "chart": {
          "caption": "Eagle Election Monitoring",
          "subCaption": "Votes collated by agents",
          "showValues": "1",
          "showPercentInTooltip": "0",
          "enableMultiSlicing": "1",
          "theme": "fusion"
        },
        "data": [{
          "label": "APC",
          "value": @apc_votes.to_s
        }, {
          "label": "PDP",
          "value": @pdp_votes.to_s
        }, {
          "label": "APGA",
          "value": @apga_votes.to_s
        }, {
          "label": "PRP",
          "value": @prp_votes.to_s
        }, {
          "label": "LABOUR PARTY",
          "value": @lab_votes.to_s
        }, {
          "label": "YPP",
          "value": @ypp_votes.to_s
        }

      ]
      }   

        # Chart rendering 
        @chart = Fusioncharts::Chart.new({
                width: "600",
                height: "400",
                type: "pie3d",
                renderAt: "chartContainer",
                dataSource: chartData
            })


end


def assembly

   @reports = Report.where(election_type: "House of Assembly")
    @polling_units = PollingUnit.all
    @council_wards = CouncilWard.all
    @pdp_votes = 0
    @apc_votes = 0
    @apga_votes = 0
    @prp_votes = 0
    @lab_votes = 0
    @ypp_votes = 0


    if @reports
          @reports.each do |u| 
              @pdp_votes += u.pdp_votes
              @prp_votes += u.prp_votes
              @ypp_votes += u.ypp_votes
              @apc_votes += u.apc_votes
              @apga_votes += u.apga_votes
              @lab_votes += u.labour_party

           end
      end



      
      chartData = {

        "chart": {
          "caption": "Eagle Election Monitoring",
          "subCaption": "Votes collated by agents",
          "showValues": "1",
          "showPercentInTooltip": "0",
          "enableMultiSlicing": "1",
          "theme": "fusion"
        },
        "data": [{
          "label": "APC",
          "value": @apc_votes.to_s
        }, {
          "label": "PDP",
          "value": @pdp_votes.to_s
        }, {
          "label": "APGA",
          "value": @apga_votes.to_s
        }, {
          "label": "PRP",
          "value": @prp_votes.to_s
        }, {
          "label": "LABOUR PARTY",
          "value": @lab_votes.to_s
        }, {
          "label": "YPP",
          "value": @ypp_votes.to_s
        }

      ]
      }   

        # Chart rendering 
        @chart = Fusioncharts::Chart.new({
                width: "600",
                height: "400",
                type: "pie3d",
                renderAt: "chartContainer",
                dataSource: chartData
            })


end

def lga_governorship

   @reports = Report.where(election_type: "Governorship", lga: params[:lga])
    @polling_units = PollingUnit.where(lga: params[:lga])
    @council_wards = CouncilWard.where(lga: params[:lga])
    @lga = params[:lga]
    @pdp_votes = 0
    @apc_votes = 0
    @apga_votes = 0
    @prp_votes = 0
    @lab_votes = 0
    @ypp_votes = 0


    if @reports
          @reports.each do |u| 
              @pdp_votes += u.pdp_votes
              @prp_votes += u.prp_votes
              @ypp_votes += u.ypp_votes
              @apc_votes += u.apc_votes
              @apga_votes += u.apga_votes
              @lab_votes += u.labour_party

           end
      end



     
      chartData = {

        "chart": {
          "caption": "Eagle Election Monitoring",
          "subCaption": "Votes collated by agents",
          "showValues": "1",
          "showPercentInTooltip": "0",
          "enableMultiSlicing": "1",
          "theme": "fusion"
        },
        "data": [{
          "label": "APC",
          "value": @apc_votes.to_s
        }, {
          "label": "PDP",
          "value": @pdp_votes.to_s
        }, {
          "label": "APGA",
          "value": @apga_votes.to_s
        }, {
          "label": "PRP",
          "value": @prp_votes.to_s
        }, {
          "label": "LABOUR PARTY",
          "value": @lab_votes.to_s
        }, {
          "label": "YPP",
          "value": @ypp_votes.to_s
        }

      ]
      }   

        # Chart rendering 
        @chart = Fusioncharts::Chart.new({
                width: "600",
                height: "400",
                type: "pie3d",
                renderAt: "chartContainer",
                dataSource: chartData
            })


end


def governorship

   @reports = Report.where(election_type: "Governorship")
    @polling_units = PollingUnit.all
    @council_wards = CouncilWard.all
    @pdp_votes = 0
    @apc_votes = 0
    @apga_votes = 0
    @prp_votes = 0
    @lab_votes = 0
    @ypp_votes = 0


    if @reports
          @reports.each do |u| 
              @pdp_votes += u.pdp_votes
              @prp_votes += u.prp_votes
              @ypp_votes += u.ypp_votes
              @apc_votes += u.apc_votes
              @apga_votes += u.apga_votes
              @lab_votes += u.labour_party

           end
      end



     
      chartData = {

        "chart": {
          "caption": "Eagle Election Monitoring",
          "subCaption": "Votes collated by agents",
          "showValues": "1",
          "showPercentInTooltip": "0",
          "enableMultiSlicing": "1",
          "theme": "fusion"
        },
        "data": [{
          "label": "APC",
          "value": @apc_votes.to_s
        }, {
          "label": "PDP",
          "value": @pdp_votes.to_s
        }, {
          "label": "APGA",
          "value": @apga_votes.to_s
        }, {
          "label": "PRP",
          "value": @prp_votes.to_s
        }, {
          "label": "LABOUR PARTY",
          "value": @lab_votes.to_s
        }, {
          "label": "YPP",
          "value": @ypp_votes.to_s
        }

      ]
      }   

        # Chart rendering 
        @chart = Fusioncharts::Chart.new({
                width: "600",
                height: "400",
                type: "pie3d",
                renderAt: "chartContainer",
                dataSource: chartData
            })


end



def lga
  @reports = Report.where(lga: params[:lga])
   @polling_units = PollingUnit.where(lga: params[:lga])
    @council_wards = CouncilWard.where(lga: params[:lga])
  @lga = params[:lga]
   @pdp_votes = 0
    @apc_votes = 0
    @apga_votes = 0
    @prp_votes = 0
    @lab_votes = 0
    @ypp_votes = 0

    if @reports
          @reports.each do |u| 
              @pdp_votes += u.pdp_votes
              @prp_votes += u.prp_votes
              @ypp_votes += u.ypp_votes
              @apc_votes += u.apc_votes
              @apga_votes += u.apga_votes
              @lab_votes += u.labour_party

           end
      end



      
      chartData = {

        "chart": {
          "caption": "Eagle Election Monitoring",
          "subCaption": "Votes collated by agents",
          "showValues": "1",
          "showPercentInTooltip": "0",
          "enableMultiSlicing": "1",
          "theme": "fusion"
        },
        "data": [{
          "label": "APC",
          "value": @apc_votes.to_s
        }, {
          "label": "PDP",
          "value": @pdp_votes.to_s
        }, {
          "label": "APGA",
          "value": @apga_votes.to_s
        }, {
          "label": "PRP",
          "value": @prp_votes.to_s
        }, {
          "label": "LABOUR PARTY",
          "value": @lab_votes.to_s
        }, {
          "label": "YPP",
          "value": @ypp_votes.to_s
        }

      ]
      }   

        # Chart rendering 
        @chart = Fusioncharts::Chart.new({
                width: "600",
                height: "400",
                type: "pie3d",
                renderAt: "chartContainer",
                dataSource: chartData
            })

end

end